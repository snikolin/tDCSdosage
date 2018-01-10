% ANALYSIS PIPELINE
% Files are saved as 'data' followed by the participant number:
% For example: data1, data2
%
% For each step in the analysis pipeline, a folder should be created to store participants' data
% These folders are:
    % 0.raw
    % 1.data
    % 2.events
    % 3.trials
    % 4.visrej
    % 5.ICs
    % 6.struct
    % 7.postICA
    % 8.reref
    % 9.ERP

%% Participants
% Listed as 1,2,3,4,...,100
S_REJ   = 33; % number/s of participants to be excluded from analysis
STUDY   = setdiff(1:100,S_REJ); % create list of participant identifiers

%% Load/Save Parameters
% Update the directory (DIR) where your data is kept:
DIR     = '/Users/firstnamelastname/Documents/MATLAB/study_folder';
VAR     = 'data';

% Files are loaded from INFOLD and saved in OUTFOLD following processing
% Update the fields below depending on the the data analysis step
INFOLD  = '0.raw';
OUTFOLD = '1.data';

%% Runscript
% This runscript can be used for batch processing of multiple participants
% For example, to generate 'events' for all participants
% copy the function listed in 'Generate Events' below
% i.e. events = sn_events(data)

for a = 1:length(STUDY)
    load(fullfile(DIR,INFOLD,strcat(VAR,num2str(STUDY(a)),'.mat')));
    
    % Add data transform function in here
    
    fullpath = fullfile(DIR,OUTFOLD,strcat(VAR,num2str(STUDY(a))));
    save(fullpath,'data');
end

%% Load Data
filename = fullfile(DIR,'0.raw',strcat(num2str(STUDY(a)),'.Poly5'));
data     = sn_readTMSiEEG(filename);

%% Preprocessing: Line Noise Removal/Filtering/Downsampling  
data = sn_preprocess(data);

TARGET_FS   = 1024;
FS          = data.fsample;
INCREMENT   = FS/TARGET_FS;

data.trial{1}   = data.trial{1}(:,1:INCREMENT:end);
data.time{1}    = data.time{1}(1,1:INCREMENT:end);
data.fsample    = TARGET_FS;

%% Generate Events
events = sn_events(data);

fullpath = fullfile(DIR,'2.events',strcat(VAR,num2str(STUDY(a))));
save(fullpath,'events');

%% Create trials 
trials = sn_trials(events);

fullpath = fullfile(DIR,'3.trials',strcat(VAR,num2str(STUDY(a))));
save(fullpath,'trials');

%% Trial rejection
visrej = sn_trialrejection(trials);

fullpath = fullfile(DIR,'4.visrej',strcat(VAR,num2str(STUDY(a))));
save(fullpath,'visrej');
    
%% ICA
ICA_data    = sn_ICAdata(visrej);
cfg         = [];
cfg.method  = 'runica';
cfg.channel = {'all','-Marker'};
comps       = ft_componentanalysis(cfg,ICA_data);

%% IC Rejection
% Plot, inspect, and identify ICs for removal
% At the prompt, list the components to reject
% Example: [3,6,7,8,9];
sn_ICAcheck(comps)

fullpath = fullfile(DIR,'5.ICs',strcat('comps',num2str(STUDY(a))));
save(fullpath,'comps');

%% Create layout for final structure
% Create blocks
struct = sn_blocks(events);

A = find(strcmp({visrej.block},'Pre NBACK'));
B = find(strcmp({visrej.block},'Dur NBACK'));
C = find(strcmp({visrej.block},'Post NBACK'));

struct(4) = visrej(A);
struct(5) = visrej(B);
struct(6) = visrej(C);

fullpath = fullfile(DIR,'6.struct',strcat(VAR,num2str(p)));
save(fullpath,'struct');
%% Reject ICs
for m = 1:length(struct)
    % Create ind component time series using original data
    cfg = [];
    cfg.unmixing    = comps.unmixing; % NxN unmixing matrix
    cfg.topolabel   = comps.topolabel; % Nx1 cell-array with the channel labels
    comp_orig       = ft_componentanalysis(cfg,struct(m));

    % Original data reconstructed excluding rejected components
    cfg             = [];
    cfg.component   = comps.rejected;
    postica(m)      = ft_rejectcomponent(cfg,comp_orig,struct(m));
end

fullpath = fullfile(DIR,'7.postICA',strcat(VAR,num2str(STUDY(a))));
save(fullpath,'postica');

%% Re-referencing to average
cfg             = [];
cfg.channel     = 'all';
cfg.refchannel  = {'all','-P9','-P10'}; % P9 and P10 were most noisy channels
cfg.reref       = 'yes';
cfg.refmethod   = 'avg';
cfg.trials      = 'all';

for n = 1:length(postica)
    temp(n) = ft_preprocessing(cfg,postica(n));
end

reref = temp;

for o = 1:length(postica)
    reref(o).event = postica(o).event;
    reref(o).block = postica(o).block;
end

fullpath = fullfile(DIR,'8.reref',strcat(VAR,num2str(STUDY(a))));
save(fullpath,'reref');

%% ERP Calculation
% To calcualte ERPs with no processing
data    = sn_ERPavg(reref,[]);

% To calculate using a low-pass filer (smoother ERPs)
lpdata  = sn_ERPavg(reref,35);
    
fullpath = fullfile(DIR,'9.ERP',strcat(VAR,num2str(p)));
save(fullpath,'data');

%% Plot ERPs
% Plot with topology
cfg             = [];
cfg.showlabels  = 'no';
cfg.fontsize    = 6;
cfg.layout      = 'custum31Nikolin.lay';
cfg.baseline    = [-0.1 0];
cfg.xlim        = [-0.2 0.6];

for f = 1:length(post)
    figure;
    ft_multiplotER(cfg,data.post(f),data.dur(f)); 
    title(post(f).trialinfo.test);
end
