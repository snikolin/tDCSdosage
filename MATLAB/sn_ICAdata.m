function ICA_data = sn_ICAdata(visrej)
% Takes input and creates concatenated file of non-tDCS trials

A = find(strcmp({visrej.block},'Pre EEG'));
B = find(strcmp({visrej.block},'Post EEG'));
C = find(strcmp({visrej.block},'Pre NBACK'));
D = find(strcmp({visrej.block},'Post NBACK'));

fs = visrej(1).fsample;

ICA_data            = visrej(1); % used as a template for other data
ICA_data.trial      = [];
ICA_data.time       = [];
ICA_data.trial{1}   = horzcat(visrej(A).trial{:},...
                            visrej(B).trial{:},...
                            visrej(C).trial{:},...
                            visrej(D).trial{:});
ICA_data.time{1}    = (1:length(ICA_data.trial{1}))/fs;
ICA_data.sampleinfo = vertcat(visrej(A).sampleinfo,...
                            visrej(B).sampleinfo,...
                            visrej(C).sampleinfo,...
                            visrej(D).sampleinfo);
ICA_data.block      = {'Non-tDCS Data'};