close all;
clearvars -except selpath;

%% Subplot 1 - mothers
cd([selpath, '/data/mothers']);

lalA_m=readmatrix('mothers_syncidx_ΔlalA [LL].csv');
ldpA_m=readmatrix('mothers_syncidx_ΔldpA [LL].csv');
pex_m=readmatrix('mothers_syncidx_Δpex [LL].csv');
prkE_m=readmatrix('mothers_syncidx_ΔprkE [LL].csv');
wt_m=readmatrix('mothers_syncidx_WT (ΔlalA) [LL].csv');


%color palette 
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];
cp=cp./255;


figure; subplot(2,1,1);

f(1)=plot(wt_m(:,1),smooth(wt_m(:,2)),'m','DisplayName', 'WT','LineWidth',1); f(1).Color=cp(1,:); hold on;
f(2)=plot(lalA_m(:,1),smooth(lalA_m(:,2)),'r','DisplayName', '\it\DeltalalA','LineWidth',1); f(2).Color=cp(5,:); hold on;
f(3)=plot(ldpA_m(:,1),smooth(ldpA_m(:,2)),'b','DisplayName', '\it\DeltaldpA','LineWidth',1); f(3).Color=cp(2,:); hold on;
f(4)=plot(pex_m(:,1),smooth(pex_m(:,2)),'g','DisplayName', '\it\Deltapex','LineWidth',1); f(4).Color=cp(3,:); hold on;
f(5)=plot(prkE_m(:,1),smooth(prkE_m(:,2)),'y','DisplayName', '\it\DeltaprkE','LineWidth',1); f(5).Color=[0.9290 0.6940 0.1250]; hold on; 

% f(1)=plot(wt_m(:,1),smooth(wt_m(:,2)),'m','DisplayName', 'WT','LineWidth',1); f(1).Color=cp(1,:); hold on;
% f(2)=plot(lalA_m(:,1),smooth(lalA_m(:,2)),'r','DisplayName', '$\Delta$\it lalA','LineWidth',1); f(2).Color=cp(5,:); hold on;
% f(3)=plot(ldpA_m(:,1),smooth(ldpA_m(:,2)),'b','DisplayName', '$\Delta$\it ldpA','LineWidth',1); f(3).Color=cp(2,:); hold on;
% f(4)=plot(pex_m(:,1),smooth(pex_m(:,2)),'g','DisplayName', '$\Delta$\it pex','LineWidth',1); f(4).Color=cp(3,:); hold on;
% f(5)=plot(prkE_m(:,1),smooth(prkE_m(:,2)),'y','DisplayName', '$\Delta$\it prkE','LineWidth',1); f(5).Color=[0.9290 0.6940 0.1250]; hold on; 

for ff=1:5
    f(ff).LineWidth=2;
end

%adjusting the colors
f(5).Color=cp(4,:);


xlabel('Time (h)');
ylabel({'Synchronisation', 'index'});
xticks(0:12:140); xlim([0 110]); xtickangle(45);
legend ([f(1),f(3),f(4),f(5),f(2)],'Location','bestoutside');
title ('Clock synchronisation between mother cells');

xlim([3 93]);
ylim([0.5 1.1]);yticks(0.6: 0.2 :1);


%% Subplot 2 -- daughters 

%load the data
cd([selpath, '/data/daughters']);

wt=readmatrix('daughter_phasediff_mean_WT (ΔlalA) [LL].csv');
lalA=readmatrix('daughter_phasediff_mean_ΔlalA [LL].csv');
pex=readmatrix('daughter_phasediff_mean_Δpex [LL].csv');
prkE=readmatrix('daughter_phasediff_mean_ΔprkE [LL].csv');
ldpA=readmatrix('daughter_phasediff_mean_ΔldpA [LL].csv');

subplot(2,1,2);
hold on; s(1)=errorbar(wt(:,1), wt(:,2), wt(:,3),'om', 'DisplayName', 'WT', 'LineWidth',1); ylim([-0.5 0.5]);
hold on; s(2)=errorbar(lalA(:,1)-0.01, lalA(:,2), lalA(:,3),'or','DisplayName', '\it\DeltalalA','LineWidth',1); ylim([-0.5 0.5]);
hold on; s(3)=errorbar(pex(:,1)-0.015, pex(:,2), pex(:,3),'og','DisplayName', '\it\Deltapex','LineWidth',1); ylim([-0.5 0.5]);
hold on; s(4)=errorbar(prkE(:,1)+0.01, prkE(:,2), prkE(:,3),'oy','DisplayName', '\it\DeltaprkE','LineWidth',1); ylim([-0.5 0.5]);  s(4).Color=[0.9290 0.6940 0.1250];
hold on; s(5)=errorbar(ldpA(:,1)+0.015, ldpA(:,2), ldpA(:,3),'oy','DisplayName', '\it\DeltaldpA','LineWidth',1); ylim([-0.5 0.5]);

% hold on; s(1)=errorbar(wt(:,1), wt(:,2), wt(:,3),'om', 'DisplayName', 'WT', 'LineWidth',1); ylim([-0.5 0.5]);
% hold on; s(2)=errorbar(lalA(:,1)-0.01, lalA(:,2), lalA(:,3),'or','DisplayName', '$\Delta$\it lalA','LineWidth',1); ylim([-0.5 0.5]);
% hold on; s(3)=errorbar(pex(:,1)-0.015, pex(:,2), pex(:,3),'og','DisplayName', '$\Delta$\it pex','LineWidth',1); ylim([-0.5 0.5]);
% hold on; s(4)=errorbar(prkE(:,1)+0.01, prkE(:,2), prkE(:,3),'oy','DisplayName', '$\Delta$\it prkE','LineWidth',1); ylim([-0.5 0.5]);  s(4).Color=[0.9290 0.6940 0.1250];
% hold on; s(5)=errorbar(ldpA(:,1)+0.015, ldpA(:,2), ldpA(:,3),'oy','DisplayName', '$\Delta$\it ldpA','LineWidth',1); ylim([-0.5 0.5]); 

%adjusting the colors
s(1).Color=cp(1,:);
s(2).Color=cp(5,:);
s(5).Color=cp(2,:);
s(3).Color=cp(3,:);
s(4).Color=cp(4,:);


xlabel('Phase');
ylabel('Error');

title('Clock phase differences at division')

legend ([s(1),s(5), s(3), s(4), s(2)],'Location','bestoutside');
yticks(-0.5:0.1:0.5); ylim([- 0.25 0.25]);
xlim([-0.1 1]); xticks(0:0.2:1); xtickangle(45);

%% Saving - disabled
cd([selpath,'/figures/fig2']);
fname='fig2D';
%fig_save_font_20;
fig_save_font_20_ssf;
