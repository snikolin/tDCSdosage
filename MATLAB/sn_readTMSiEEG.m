function data = sn_readTMSiEEG(filename)
% Read .poly5 data and convert it to a .mat file format

% Parameters
EEG_CH  = [1:31]; 
ECG_CH  = 65;
MRKR_CH = 73;
LABELS  = {'O1','Oz','O2','P4','P3',...
    'Cz','Poz','Pz','P7','P9',...
    'Fc5','Fc1','T7','C3','Cp5',...
    'Cp1','P8','P10','Fc6','Fc2',...
    'T8','C4','Cp6','Cp2','Fp1',...
    'Fpz','Fp2','F8','F7','Fz',...
    'Afz','ECG','Marker'}';

% Load
fullpath    = fullfile(filename);
temp        = tms_read(fullpath);

channels = cat(2,EEG_CH,ECG_CH,MRKR_CH);

% Create fieldtrip-friendly format
data.trial      = {cat(1,temp.data{channels})}; 
data.fsample    = temp.fs; 
data.time       = {(1:size(data.trial{1},2))/data.fsample};
data.label      = LABELS;
    
data.hdr.Fs             = temp.header.FS;
data.hdr.nChans         = length(channels);
data.hdr.nSamples       = temp.header.NumberOfSamplePeriods;
data.hdr.nSamplesPre    = 0;
data.hdr.nTrials        = 1;
data.hdr.label          = data.label;
data.hdr.chantype       = {'EEG','EEG','EEG','EEG','EEG','EEG','EEG',...
    'EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG',...
    'EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG','EEG',...
    'EEG','EEG','ECG','Marker'}';
data.hdr.chanunit       = {'uV','uV','uV','uV','uV','uV','uV','uV',...
    'uV','uV','uV','uV','uV','uV','uV','uV','uV','uV','uV','uV',...
    'uV','uV','uV','uV','uV','uV','uV','uV','uV','uV','uV','uV','V'}';
data.hdr.measurementdate        = temp.measurementdate;
data.hdr.path                   = temp.path;
data.hdr.filename               = temp.filename;
data.hdr.measurementtime        = temp.measurementtime;
data.hdr.measurementduration    = temp.measurementduration;
