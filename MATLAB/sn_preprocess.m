function data = sn_preprocess(data)

LINE_NOISE  = 50;
MARKER      = strcmp(data.label,'Marker');

% Remove line noise
[b,a] = butter(2, ([LINE_NOISE*0.99 LINE_NOISE*1.01])/(data.fsample * 0.5),'stop');
data.trial{1}(1:31,:) = filtfilt(b,a,data.trial{1}(1:31,:)')';

% Filtering
cfg = [];
cfg.bpfilter    = 'yes';
cfg.bpfiltord   = 2;
cfg.demean      = 'yes';
cfg.channel     = {'all', '-ECG', '-Marker'};
cfg.bpfreq      = [0.5 70];
marker_ch       = data.trial{1}(MARKER,:);   

data                = ft_preprocessing(cfg,data); % 44secs
data.trial{1}(32,:) = marker_ch;
data.label(32,1)    = {'Marker'};
