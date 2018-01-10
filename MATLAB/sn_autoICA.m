function sn_autoICA(comps) % comps.topo: channels x IC
%% Parameters
FS          = comps.fsample;
THRES_B     = 2.5; % blink threshold
THRES_L     = 4; % lateral eye movement threshold 
THRES_M     = 0.5; % muscle activity threshold

% Frequencies
FREQ        = [0 150];
MUSCLE_FREQ = [31 100];

% Channels
FP1         = find(strcmp(comps.topolabel,'Fp1'));
FPz         = find(strcmp(comps.topolabel,'Fpz'));
FP2         = find(strcmp(comps.topolabel,'Fp2'));
F7          = find(strcmp(comps.topolabel,'F7'));
F8          = find(strcmp(comps.topolabel,'F8'));

%% PSD Calculations
% Needs to be sped up - timeseries is long!
for a = 1:size(comps.trial{1},1)
    [P,F]   = pwelch(comps.trial{1}(a,:),FS,FS/2,FS,FS);
    index   = find(F > FREQ(1) & F < FREQ(2));
    PSD(a,:)= P(index);
end
F = F(index);

%% Z-Scores
% Calculate TOPOLOGY z-scores
ztopo = zscore(comps.topo,0,1);

%% Blink ICs
% Average zscore of Fp1, Fp2, and Fpz should be greater than 2.5
blinkmean   = mean(ztopo([FP1,FP2,FPz],:));
blinks      = find(abs(blinkmean) > THRES_B);

%% Lateral Eye Movement
lateral     = find(abs(ztopo(F7,:) - ztopo(F8,:)) > THRES_L);
 % ALTERNATIVE: find(ztopo([F7],:) > THRES_L & ztopo([F8],:) < THRES_L |...
 %                   ztopo([F7],:) < THRES_L & ztopo([F8],:) > THRES_L);

%% Muscle ICs
m_activity  = zeros(1,length(comps.topo));
i           = F >= MUSCLE_FREQ(1) & F <= MUSCLE_FREQ(2);

for m = 1:length(comps.topo)
    m_activity(m) = sum(PSD(m,i))/sum(PSD(m,:));
end

muscle      = find(m_activity > THRES_M);

%% Display output
disp(['Blink components are: ', num2str(blinks)]);
disp(['Lateral eye movement components are: ', num2str(lateral)]);
disp(['Muscle components are: ', num2str(muscle)]);

