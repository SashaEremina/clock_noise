close all; clear all;

%load the data - mother sync index
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\mothers']);

wt_m1=readmatrix('mothers_syncidx_WT (ΔKaiBC) [low LL].csv');
wt_m2=readmatrix('mothers_syncidx_WT (ΔKaiBC) [LL].csv');
wt_m3=readmatrix('mothers_syncidx_WT (ΔKaiC-R215C) [high LL].csv');

%load the data - phase difference at division
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\daughters']);
wt=readmatrix('daughter_phasediff_mean_WT (ΔkaiBC) [LL].csv');

%supplementary fig for comparison
wt1=readmatrix('daughter_phasediff_mean_WT (ΔlalA) [LL].csv'); %old submission
wt2=readmatrix('daughter_phasediff_mean_WT (ΔkaiBC) [LL].csv');


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
errorbar(wt(:,1), wt(:,2), wt(:,3),'ob', 'DisplayName', 'WT', 'LineWidth',1); ylim([-0.5 0.5]);
xlabel('Phase');
ylabel('Error'); yticks([-0.5:0.1:0.5]); ylim([- 0.25 0.25])
title('Clock phase inheritance at cell division')

%% Saving - disabled
cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
fname='fig1H';
fig_save_font_22;

%% Supplementary fig for comparisoon
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
errorbar(wt1(:,1), wt1(:,2), wt1(:,3),'ob', 'DisplayName', 'WT ($\Delta$lalA)', 'LineWidth',1); ylim([-0.5 0.5]);
hold on; errorbar(wt2(:,1), wt2(:,2), wt2(:,3),'og', 'DisplayName', 'WT ($\Delta$kaiBC)', 'LineWidth',1); ylim([-0.5 0.5]);
legend('NumColumns',2);

xlabel('Phase');
ylabel('Error'); yticks([-0.5:0.1:0.5]); ylim([- 0.25 0.25])
title('Clock phase inheritance at cell division');

%% Saving - disabled
cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
fname='fig1H_comparison';
fig2_save_font_22;

