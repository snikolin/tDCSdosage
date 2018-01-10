function data = sn_ERPavg(reref,lpfreq)
% Using structure array with EEG and NBACK data, output ERP averages

A = find(strcmp({reref.block},'Pre NBACK'));
B = find(strcmp({reref.block},'Dur NBACK'));
C = find(strcmp({reref.block},'Post NBACK'));

BASE    = [-0.5 -0.2];

TYPE{1} = {'hit','fa','miss','stimulus'}; % all
TYPE{2} = {'hit','miss'}; % targets
TYPE{3} = {'stimulus','fa'}; % nontargets
TYPE{4} = {'hit','fa'}; % responses
TYPE{5} = {'stimulus','miss'}; % nonresponses
TYPE{6} = {'hit'}; % hits
TYPE{7} = {'stimulus'}; % stimuli
TYPE{8} = {'pre3hits'}; % 3 stim before each hit
TYPE{9} = {'pre1hit'};
TYPE{10} = {'pre2hit'};
TYPE{11} = {'pre3hit'};

CAT{1}  = 'all';
CAT{2}  = 'targets';
CAT{3}  = 'nontargets';
CAT{4}  = 'responses';
CAT{5}  = 'nonresponses';
CAT{6}  = 'hits';
CAT{7}  = 'stimuli';
CAT{8}  = 'pre3hits';
CAT{9}  = 'pre1hit';
CAT{10} = 'pre2hit';
CAT{11} = 'pre3hit';

for t = [A,B,C] % Pre/Dur/Post
    for a = 1:length(TYPE)
        cfg             = [];
        tempdata        = reref(t);
        index           = sn_index(tempdata,TYPE{a});
        tempdata.trial  = tempdata.trial(index);
        tempdata.time   = tempdata.time(index);
        
        % Baseline correction and optional low-pass filtering
        cfg                 = [];
        cfg.demean          = 'yes';
        cfg.baselinewindow  = BASE;
        
        if any(lpfreq)
            cfg.lpfilter    = 'yes';
            cfg.lpfreq      = lpfreq;
        end
        
        tempdata        = ft_preprocessing(cfg,tempdata);
        
        if t == A
            data.pre(a) = ft_timelockanalysis(cfg,tempdata);
        end
        if t == B
            data.dur(a) = ft_timelockanalysis(cfg,tempdata);
        end
        if t == C
            data.post(a) = ft_timelockanalysis(cfg,tempdata);
        end
    end
end

for b = 1:length(CAT)
    data.pre(b).stimtype    = CAT{b};
    data.dur(b).stimtype    = CAT{b};
    data.post(b).stimtype   = CAT{b};
end
