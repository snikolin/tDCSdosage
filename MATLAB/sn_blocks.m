function meta = sn_blocks(data) 
EOG     = find(strcmp({data.event.type},'eeg'));
INDEX   = zeros(length(EOG),2);
LABELS  = {'PreEEG','DurEEG','PostEEG'};

for a = 1:length(EOG)
    EOG_start   = data.event(EOG(a)).sample;
    EOG_end     = data.event(EOG(a)).sample + data.event(EOG(a)).sampdur - 1;
    INDEX(a,:)  = [EOG_start, EOG_end];
end

% Create blocks
for b = 1:size(INDEX,1)
    tempdata            = data;
    tempdata.label      = tempdata.label(1:31);
    tempdata.trial{1}   = data.trial{1}(1:31,INDEX(b,1):INDEX(b,2));
    tempdata.time{1}    = data.time{1}(1,INDEX(b,1):INDEX(b,2));
    tempdata.sampleinfo = [INDEX(b,1),INDEX(b,2)];
    tempdata.event      = data.event(EOG(b));
    tempdata.block      = LABELS{b};
    tempdata.trialinfo  = [];
    
    meta(b) = tempdata;
end
% remove fields using
% meta = rmfield(meta,'trialinfo');
meta = orderfields(meta,sort(fieldnames(meta)));


% N.B. To add NBACK
% pre_nback   = (EOG(1) + 1):(EOG(2) - 1);
% dur_nback   = (EOG(2) + 1):(EOG(3) - 1);
% post_nback  = (EOG(3) + 1):length(data.event);
% INDEX(3,:)  = [data.event(dur_nback(1)).sample - (0.5 * data.fsample),...
%     data.event(dur_nback(end)).sample + (2 * data.fsample) - 1];
% INDEX(5,:)  = [data.event(post_nback(1)).sample - (0.5 * data.fsample),...
%     data.event(post_nback(end)).sample + (2 * data.fsample) - 1];
