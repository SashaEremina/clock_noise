close all;
clearvars -except selpath;

%% load the data - wt
cd([selpath, '/data/p2pstats_errorbars']);

WT_ml_1=readmatrix('p2pstats_bootstrap_WT [LL].csv');
WT_ll=readmatrix('p2pstats_bootstrap_WT [low LL].csv');
WT_hl=readmatrix('p2pstats_bootstrap_WT [high LL].csv');

WT_ml_2=readmatrix('p2pstats_bootstrap_WT (ΔlalA) [LL].csv');
WT_ml_3=readmatrix('p2pstats_bootstrap_WT (KaiC-R215C) [medium LL].csv');

WT_Ab=readmatrix('p2pstats_bootstrap_WT-Ab [LL].csv'); 

%% load the data - del_regs

lalA=readmatrix('p2pstats_bootstrap_ΔlalA [LL].csv');
ldpA=readmatrix('p2pstats_bootstrap_ΔldpA [LL].csv');
pex=readmatrix('p2pstats_bootstrap_Δpex [LL].csv');
prkE=readmatrix('p2pstats_bootstrap_ΔprkE [LL].csv');

ldpA2=readmatrix('p2pstats_bootstrap_ΔldpA (repeat) [LL].csv');
prkE2=readmatrix('p2pstats_bootstrap_ΔprkE (repeat) [LL].csv');

%%
figure; subplot(1,2,1);

hold on; h(1)=errorbar(WT_ml_1(1:5,1)+0.1, WT_ml_1(1:5,3), WT_ml_1(1:5,3)-WT_ml_1(1:5,6), WT_ml_1(1:5,7)-WT_ml_1(1:5,3),'DisplayName','WT$\mathrm{-1}$');
hold on; h(2)=errorbar(WT_ml_2(1:5,1)+0.1, WT_ml_2(1:5,3), WT_ml_2(1:5,3)-WT_ml_2(1:5,6), WT_ml_2(1:5,7)-WT_ml_2(1:5,3),'DisplayName','WT$\mathrm{-2}$');
hold on; h(3)=errorbar(WT_ml_3(1:5,1)+0.1, WT_ml_3(1:5,3), WT_ml_3(1:5,3)-WT_ml_3(1:5,6), WT_ml_3(1:5,7)-WT_ml_3(1:5,3),'DisplayName','WT$\mathrm{-3}$');

for hh=1:1:length(h)
    h(hh).Marker='square';
    h(hh).MarkerSize=10;
    h(hh).LineWidth=1.5;
end

h(1).Color=[0 0.4470 0.7410];
h(2).Color=[0.4940 0.1840 0.5560];
h(3).Color=[0.3010 0.7450 0.9330];

xlim([0 4]);

%% Figure styling
legend ([h(1) h(2) h(3)],'Location','northwest','NumColumns',1);
ylim([0 5.5])
xlim([0 4.2]); xticks(0:1:4);
xticklabels({'0','1','2','3','4'});

%% Pt 2 - del regs
hold on; subplot(1,2,2);

hold on; h(4)=errorbar(lalA(1:5,1)+0.1, lalA(1:5,3), lalA(1:5,3)-lalA(1:5,6), lalA(1:5,7)-lalA(1:5,3),'DisplayName','$\Delta$\it lalA');
hold on; h(5)=errorbar(ldpA(1:5,1)+0.1, ldpA(1:5,3), ldpA(1:5,3)-ldpA(1:5,6), ldpA(1:5,7)-ldpA(1:5,3),'DisplayName','$\Delta$\it ldpA');
hold on; h(6)=errorbar(pex(1:5,1)+0.1, pex(1:5,3), pex(1:5,3)-pex(1:5,6), pex(1:5,7)-pex(1:5,3),'DisplayName','$\Delta$\it pex');
hold on; h(7)=errorbar(prkE(1:4,1)+0.1, prkE(1:4,3), prkE(1:4,3)-prkE(1:4,6), prkE(1:4,7)-prkE(1:4,3),'DisplayName','$\Delta$\it prkE');

hold on; h(8)=errorbar(ldpA2(1:5,1)+0.1, ldpA2(1:5,3), ldpA2(1:5,3)-ldpA2(1:5,6), ldpA2(1:5,7)-ldpA2(1:5,3),'DisplayName','$\Delta$\it{ldpA}$\mathrm{-2}$');
hold on; h(9)=errorbar(prkE2(1:5,1)+0.1, prkE2(1:5,3), prkE2(1:5,3)-prkE2(1:5,6), prkE2(1:5,7)-prkE2(1:5,3),'DisplayName','$\Delta$\it{prkE}$\mathrm{-2}$');


for hh=4:1:length(h)
    h(hh).Marker='square';
    h(hh).MarkerSize=10;
    h(hh).LineWidth=1.5;
end

legend ([h(4) h(5) h(8) h(6) h(7) h(9)],'Location','northwest','NumColumns',1);
ylim([0 5.5])
xlim([0 4.2]); xticks(0:1:4);
xticklabels({'0','1','2','3','4'});

%Figure styling 
ax = axes(figure (1));
han = gca;
han.Visible = 'off';

han.YLabel.Visible = 'on';
ylabel ('Trough-to-trough variance');

han.XLabel.Visible = 'on';
xlabel ('Trough-to-trough distance (d)');


%% Saving
cd([selpath, '/figures/fig4']);
fname='fig_s4_2';
fig_save_font_20;

