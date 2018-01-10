function sn_ICAcheck(participant)
% Identify which components are to be removed
% Done through automated process with follow-up visual confirmation

% Load
DIR     = '/Users/stevannikolin/Documents/MATLAB/s2/5.ICs';
DIR2    = '/Volumes/TOSHIBA EXT/s2/5.ICs';
load(fullfile(DIR,strcat('comps',num2str(participant),'.mat')));

% Automated process to suggest components for removal
sn_autoICA(comps)

% Visual inspection of components
sn_plotICA(comps);

% Creates prompt for user to include which components need to be rejected
prompt          = 'list components to reject. Approximately 10-15% of total:';
x               = input(prompt);
comps.rejected  = x;

fullpath = fullfile(DIR,strcat('comps',num2str(participant)));
fullpath2 = fullfile(DIR2,strcat('comps',num2str(participant)));
save(fullpath,'comps');
save(fullpath2,'comps')