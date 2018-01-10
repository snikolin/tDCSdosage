function sn_plotICA(comp)

% Parameters
FREQ = [0 70];
NDISP = 8;
SIG_THRESHOLD = 2.5;
fs = comp.fsample;
xlim = comp.time{1}([1 end]);
ncomp = size(comp.trial{1},1);

% PSD
for a = 1:size(comp.trial{1},1)
    [psd,freq]  = pwelch(comp.trial{1}(a,:),fs*4,fs,fs*2,fs);
    i           = find(freq>=FREQ(1) & freq<=FREQ(2));
    P(a,:)      = psd(i);
    fit(a,:)    = polyfit(freq(i),log(psd(i)),1);
    if a == size(comp.trial{1},1)
        F           = freq(i);
    end
end

% Z-scores
ztopology   = zscore(comp.topo,0,1);
zfit        = zscore(fit,0,1);

% Screen parameters
pos = get(groot,'Screensize');
pos(3) = pos(4)/8*3;
set(gcf,'position',pos)

% Plot ICs 8 at a time
for n=1:ceil(ncomp/NDISP)
    clf
    for m = 1:NDISP
        c = (n-1)*NDISP+m;
        if c>ncomp
            continue
        end
        
        subplot('position',[0.07, 1.03-m/NDISP*.98, 0.25, 0.08])
        plot(comp.time{1},comp.trial{1}(c,:));
        axis tight
        set(gca,'xlim',xlim,'fontsize',8)
        box off
        title(['component ',num2str(c)],'fontsize',10);
        if m==8
            xlabel('time [s]')
        end
        
        subplot('position',[0.37, 1.03-m/NDISP*.98, 0.25, 0.08])
        semilogy(F,P(c,:));
        box off
        axis tight
        set(gca,'fontsize',8)
        
        logP    = log(P(c,:));
        xaxis   = round(FREQ(2)*0.7);
        yaxis1  = exp((max(logP)-min(logP))*0.90 + min(logP));
        yaxis2  = exp((max(logP)-min(logP))*0.75 + min(logP));
        txt1    = text(xaxis,yaxis1,num2str(fit(c,1),'%.2f'),'fontsize',8); % slope
        if abs(zfit(c,1)) >= SIG_THRESHOLD
            set(txt1,'Color','red')
        end
        txt2    = text(xaxis,yaxis2,num2str(fit(c,2),'%.2f'),'fontsize',8); % intercept
        if abs(zfit(c,2)) >= SIG_THRESHOLD
            set(txt2,'Color','red')
        end
        if m==1
            title('PSDs','fontsize',10);
        end
        if m==8
            xlabel('freq [Hz]','fontsize',9)
        end
                
        subplot('position',[0.66, 1.01-m/NDISP*.98, 0.33, 0.113])
        cfg             = [];
        cfg.layout      = 'custum31Nikolin.lay';
        cfg.component   = c;
        cfg.comment     = 'no';
        cfg.title       = 'off';
        cfg.comment     = 'no';
        cfg.feedback    = 'no';
        cfg.colorbar    = 'yes';
        
        sigchannels             = find(abs(ztopology(:,c)) > SIG_THRESHOLD);
        cfg.highlight           = 'on';
        cfg.highlightchannel    = sigchannels;
        cfg.highlightsymbol     = '*';
        cfg.highlightcolor      = 'red';
        cfg.highlightsize       = 6;
        cfg.highlightfontsize   = 6;
        
        ft_topoplotIC(cfg,comp);
        set(gca,'fontsize',8)
        if m==1
            title('Topoplot','fontsize',10);
        end
    end
    drawnow
    h = uicontrol('Position',[pos(3)/2-80,10,160 30],'String','Next',...
        'Callback','uiresume(gcbf)','FontWeight','bold','FontSize',12,...
        'ForegroundColor',[0 0 1], 'BackgroundColor',[1 1 1]);
    uiwait(gcf);
end


