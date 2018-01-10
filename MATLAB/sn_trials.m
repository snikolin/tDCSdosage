function trials = sn_trials(data)
% Create EEG trials
EEG             = find(strcmp({data.event.type},'eeg'));
EEG_LABELS      = {'Pre EEG','Dur EEG','Post EEG'};
mkr             = find(strcmp(data.label,'Marker'));
chs             = setdiff(1:length(data.label),mkr); % allows removal of marker channel

for s = 1:length(EEG)
    tempdata    = data;
    EEG_start   = tempdata.event(EEG(s)).sample;
    EEG_end     = tempdata.event(EEG(s)).sample + tempdata.event(EEG(s)).sampdur - 1;
    index       = EEG_start:EEG_end;

    % Amount of full 1sec segments that can be extracted from trial data
    total_secs  = floor(length(index)/tempdata.fsample);
    remainder   = length(index) - total_secs * tempdata.fsample;
    
    % Ignore first <1s remainder of data and keep the rest
    A = tempdata.trial{1}(chs,index((remainder + 1):end));
    B = mat2cell(A,length(chs),repmat(tempdata.fsample,total_secs,1));
    tempdata.trial          = B;

    C = tempdata.time{1}(1,index((remainder + 1):end));
    D = mat2cell(C,1,repmat(tempdata.fsample,total_secs,1));
    tempdata.time           = D;
    
    for t = 1:length(tempdata.trial)
        tempevent(t).type       = 'eeg';
        tempevent(t).value      = 254;
        tempevent(t).sample     = index(remainder + 1) + ((t - 1) * tempdata.fsample);
        tempevent(t).timestamp  = tempdata.time{t}(1,1);
        tempevent(t).sampdur    = size(tempdata.trial{t},2);
        tempevent(t).duration   = tempevent(t).sampdur/tempdata.fsample;
    end
    
    tempdata.sampleinfo     = [];
    tempdata.sampleinfo(:,1)= index(remainder + 1):tempdata.fsample:EEG_end;
    tempdata.sampleinfo(:,2)= [(tempdata.sampleinfo(2:end,1) - 1); EEG_end];
    tempdata.event          = tempevent;
    tempdata.block          = EEG_LABELS{s};
    tempdata.label(mkr) = []; % remove marker channel from labels

    trials(s) = tempdata;    
end

% Create NBACK trials
PRE_STIM    = 0.5; % seconds
POST_STIM   = 1.5; % seconds
nback{1}    = (EEG(1) + 1):(EEG(2) - 1);
nback{2}    = (EEG(2) + 1):(EEG(3) - 1);
nback{3}    = (EEG(3) + 1):length(data.event);

row = length(EEG);
NBACK_LABELS = {'Pre NBACK','Dur NBACK','Post NBACK'};
for seg = 1:length(nback)
    
    temptrial   = [];
    temptime    = [];
    sampleinfo  = [];
    tempdata    = [];
    
    for d = 1:length(nback{seg})
        index_start     = data.event(nback{seg}(1,d)).sample - round((data.fsample * PRE_STIM));
        index_end       = data.event(nback{seg}(1,d)).sample + round((data.fsample * POST_STIM)) - 1;
        temptrial{d}    = data.trial{1}(chs,index_start:index_end);
        temptime{d}     = -PRE_STIM:1/data.fsample:(POST_STIM - (1/data.fsample));  % data.time{1}(1,index_start:index_end);
        sampleinfo(d,:) = [index_start, index_end];
    end
    
    tempdata            = data;
    tempdata.trial      = temptrial;
    tempdata.time       = temptime;
    tempdata.sampleinfo = [];
    tempdata.sampleinfo = sampleinfo;
    tempdata.label(mkr) = []; % remove marker channel from labels
    tempdata.event      = data.event(nback{seg}(1,:));
    tempdata.block      = NBACK_LABELS{seg};
    
    trials(row + seg)   = tempdata;
end