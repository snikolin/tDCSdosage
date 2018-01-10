function data = sn_events(data)

MARKER = strcmp(data.label,'Marker');

trigger = data.trial{1}(MARKER,:);
dif_trigger = [0,diff(trigger)~=0];              % is 1 when value changes
trigger = trigger.*dif_trigger;                  % set trigger to 0 if it doesn't change
trigger(1,end) = 250;                            % set final trigger to end value 250   
i = find(trigger);                               % indices of triggers

event_data(:,1) = trigger(i);                    % Value of the amplifier (252:255)
event_data(:,2) = i;                             % Sample location of the events
event_data(:,3) = i/data.fsample;                % Time of event in seconds
event_data(:,4) = [diff(event_data(:,2)); 0];    % Duration of events in samples
event_data(:,5) = event_data(:,4)/data.fsample;  % Duration of events in seconds

% Categorise events into hits, misses, false alarms, stimuli, and resting
% state
stim = find(event_data(:,1) == 254);
for q = 1:length(stim)
    if event_data((stim(q) + 1),1) == 252
        event_data(stim(q),6) = 1; % Hit        
    elseif event_data((stim(q) + 1),1) == 255
        event_data(stim(q),6) = 2; % Miss
    end
end

nostim = find(event_data(:,1) == 253);
for r = 1:length(nostim)
    if event_data((nostim(r) - 1),1) == 255 && event_data((nostim(r) + 1),1) == 252
        event_data(nostim(r),6) = 3; % False alarm (FA)     
    elseif event_data((nostim(r) - 1),1) == 255 && event_data((nostim(r) + 1),1) == 255
        event_data(nostim(r),6) = 4; % Stimulus
    end
end
        
EEG_triggers = find(event_data(:,5) > 280 & event_data(:,5) < 305 & event_data(:,1) == 254);
if length(EEG_triggers) ~=3 
    clc;
    error('Check the marker channel! Too many/few resting state EEG recordings');
end
for e = 1:length(EEG_triggers)
    if event_data(EEG_triggers(e),1) == 254
        event_data(EEG_triggers(e),6) = 5; % EEG resting state             
    end
end

%% Create Events list
TRIGGERS = [1,2,3,4,5];
TYPE = {'hit','miss','fa','stimulus','eeg'};

event_index = find(event_data(:,6));
for n = 1:length(event_index)
    [~,j] = intersect(TRIGGERS,event_data(event_index(n),6));
    data.event(n).type = TYPE{j};                             % event type (hit etc...)
    data.event(n).value = event_data(event_index(n),1);       % trigger value
    data.event(n).sample =  event_data(event_index(n),2);     % sample index
    data.event(n).timestamp = event_data(event_index(n),3);   % time of event
    data.event(n).sampdur = event_data(event_index(n),4);     % duration (samples)
    data.event(n).duration = event_data(event_index(n),5);    % duration (seconds)
end