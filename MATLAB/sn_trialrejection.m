function result = sn_trialrejection(input)
% Removes trials that have a maxzvalue > THRESHOLD
% EOG
    % Rejection Criteria/Threshold
    % Range > 200
    % Var   > 3000
    % Max z > 12
% Visual method
    % cfg         = [];
    % cfg.method  = 'summary';
    % cfg.channel = {'all','-Marker'};
    % cfg.metric  = 'maxzvalue';
    % for a = 1:length(trials)
    %     visrej(a) = ft_rejectvisual(cfg,trials(a));
    % end

for row = 1:length(input)
    data = input(row);

    THRESHOLD   = 12; % maxzscore allowed = 12
    MARKER      = strcmp(data.label,'Marker');
    SAMPLES     = length(data.time{1});
    TRIALS      = length(data.trial);

    % Generate concatenated data set for calculations
    catdat           = horzcat(data.trial{:});

    % Remove marker channel from zscore calculations
    catdat(MARKER,:) = [];
    CHANNELS = size(catdat,1);

    % Convert data into zscores
    for a = 1:CHANNELS
        catdat(a,:) = catdat(a,:) - mean(catdat(a,:));
        catdat(a,:) = catdat(a,:)/std(catdat(a,:));
    end

    % Put data back into fieldtrip cell format
    trials = mat2cell(catdat,CHANNELS,repmat(SAMPLES,TRIALS,1));

    % Find the max zscore for channels and trials
    maxzscore = zeros(CHANNELS,TRIALS);
    for a = 1:TRIALS
        for b = 1:CHANNELS
            maxzscore(b,a) = max(trials{a}(b,:));
        end
    end

    % Find max zscore for trials
    maxtrials = max(maxzscore,[],1);

    % % Plot 
    % figure;
    % scatter(1:TRIALS,maxtrials);
    % hold on
    % plot([1 TRIALS],[THRESHOLD THRESHOLD],'LineStyle',...
    %     '--','Color','black');
    % hold off

    % Find trials with max zscores above threshold
    index = maxtrials > THRESHOLD;

    % Remove trials from data
    data.trial(index)        = [];
    data.time(index)         = [];
    data.event(index)        = [];
    data.sampleinfo(index,:) = [];
    data.trialinfo.rejtrls   = index;
    
    result(row)              = data;
end



