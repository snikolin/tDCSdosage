function index = sn_index(data,array)
% Enter data structure and an ARRAY of stimulus types
% Stimulus types allowed incude 'hit','miss','fa','stimulus',
% OR 'pre3hit' on its own
% Example:
% [index] = sn_index(trials(5),{'hit','fa'})

index = [];

if strcmp(array,'pre3hits')
    hits        = find(strcmp({data.event.type},'hit'));
    pre3hits    = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] < hitsamp & ...
                [data.event.sample] > (hitsamp - (3.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            pre3hits{h} = ind(~facheck);
        end
        
        index = horzcat(pre3hits{:});
        
elseif strcmp(array,'post1hit')
    hits        = find(strcmp({data.event.type},'hit'));
    post1hits    = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] > hitsamp & ...
                [data.event.sample] < (hitsamp + (1.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            post1hits{h} = ind(~facheck);
        end
        
        index = horzcat(post1hits{:});

elseif strcmp(array,'post2hit')
    hits        = find(strcmp({data.event.type},'hit'));
    post2hits   = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] > (hitsamp + (1.5*2*data.fsample)) & ...
                [data.event.sample] < (hitsamp + (2.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            post2hits{h} = ind(~facheck);
        end
        
        index = horzcat(post2hits{:});
    
elseif strcmp(array,'post3hit')
    hits        = find(strcmp({data.event.type},'hit'));
    post3hits   = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] > (hitsamp + (2.5*2*data.fsample)) & ...
                [data.event.sample] < (hitsamp + (3.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            post3hits{h} = ind(~facheck);
        end
        
        index = horzcat(post3hits{:});
 
elseif strcmp(array,'pre1hit')
    hits        = find(strcmp({data.event.type},'hit'));
    pre1hits    = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] < hitsamp & ...
                [data.event.sample] > (hitsamp - (1.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            pre1hits{h} = ind(~facheck);
        end
        
        index = horzcat(pre1hits{:});
        
elseif strcmp(array,'pre2hit')
    hits        = find(strcmp({data.event.type},'hit'));
    pre2hits    = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] < (hitsamp - (1.5*2*data.fsample)) & ...
                [data.event.sample] > (hitsamp - (2.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            pre2hits{h} = ind(~facheck);
        end
        
        index = horzcat(pre2hits{:});     

elseif strcmp(array,'pre3hit')
    hits        = find(strcmp({data.event.type},'hit'));
    pre3hit     = [];
        for h = 1:length(hits)
            hitsamp = data.event(hits(h)).sample;
            ind = [];
            ind = find([data.event.sample] < (hitsamp - (2.5*2*data.fsample)) & ...
                [data.event.sample] > (hitsamp - (3.5*2*data.fsample)));
            facheck = strcmp({data.event(ind).type},'fa');
            pre3hit{h} = ind(~facheck);
        end
        
        index = horzcat(pre3hit{:});
        
else
    for a = 1:length(array)
        temp = [];
        temp = find(strcmp({data.event.type},array(a)));
        index = [index, temp];
    end
end
