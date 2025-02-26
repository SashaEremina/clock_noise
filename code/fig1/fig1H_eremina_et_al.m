close all;
clearvars -except selpath;

%% load the data - mother sync index
cd([selpath, '/data/mothers']);

wt_m1=readmatrix('mothers_syncidx_WT [low LL].csv');
wt_m2=readmatrix('mothers_syncidx_WT [LL].csv');
wt_m3=readmatrix('mothers_syncidx_WT [high LL].csv');

%load the data - phase difference at division
cd([selpath, '/data/daughters']);
wt=readmatrix('daughter_phasediff_mean_WT [LL].csv');

%color pallette
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];
cp=cp./255;

figure; 
subplot(2,1,1);
plot(wt_m1(3:end,1),smooth(wt_m1(3:end,2)),'g','DisplayName', 'low LL','LineWidth',2); hold on;
plot(wt_m2(3:end,1),smooth(wt_m2(3:end,2)),'b','DisplayName', 'medium LL','LineWidth',2); hold on;
plot(wt_m3(3:end,1),smooth(wt_m3(3:end,2)),'m','DisplayName', 'high LL','LineWidth',2); hold on;

xlabel('Time (h)');
ylabel({'Synchronisation', 'index'});
xticks(0:12:140); xlim([0 106]); ylim([0.5 1.1]); yticks(0.6:0.1:1)
legend('NumColumns',3,'Location','southwest');
title ('Clock synchronisation between mother cells');

subplot(2,1,2);
errorbar(wt(:,1), wt(:,2), wt(:,3),'ob', 'DisplayName', 'medium LL', 'LineWidth',1); ylim([-0.5 0.5]);
xlabel('Phase');
ylabel('Error'); yticks(-0.5:0.1:0.5); ylim([- 0.25 0.25])
legend('Box','on','Location','southwest');
title('Clock phase inheritance at cell division')

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig1H';
%fig_save_font_22;
fig_save_font_22_box_on_ssf;

