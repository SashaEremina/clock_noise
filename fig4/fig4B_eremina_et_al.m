close all;
clearvars -except selpath;


%% simulations
cd([selpath, '/simulations/p2pStatistics/p2p-LLvsLD_Fig4']);

s_hld=readmatrix('LDsim_p2p.csv');
s_mld=readmatrix('LDsim_low_p2p.csv');

s_ll=readmatrix('LLsim_low_p2p.csv');
s_ml=readmatrix('LLsim_p2p.csv');

%data w/ error bars
cd([selpath, '/data/p2pstats_errorbars']);

WT_ml=readmatrix('p2pstats_bootstrap_WT [LL].csv');
WT_ll=readmatrix('p2pstats_bootstrap_WT [low LL].csv');

WT_hld=readmatrix('p2pstats_bootstrap_WT [LD sq].csv');
WT_mld=readmatrix('p2pstats_bootstrap_WT [LD sq low].csv');


figure;
hold on; h(1)=errorbar(WT_ll(1:5,1)+0.1, WT_ll(1:5,3), WT_ll(1:5,3)-WT_ll(1:5,6), WT_ll(1:5,7)-WT_ll(1:5,3),'go','DisplayName','data low LL');
hold on; h(2)=errorbar(WT_ml(1:5,1), WT_ml(1:5,3), WT_ml(1:5,3)-WT_ml(1:5,6), WT_ml(1:5,7)-WT_ml(1:5,3),'bo','DisplayName','data medium LL');
hold on; h(3)=errorbar(WT_mld(1:5,1)+0.1, WT_mld(1:5,3), WT_mld(1:5,3)-WT_mld(1:5,6), WT_mld(1:5,7)-WT_mld(1:5,3),'go','DisplayName','data low LD');
hold on; h(4)=errorbar(WT_hld(1:5,1), WT_hld(1:5,3), WT_hld(1:5,3)-WT_hld(1:5,6), WT_hld(1:5,7)-WT_hld(1:5,3),'bo','DisplayName','data medium LD');

v=[0 1 2 3];
hold on; h(5)=plot(v,s_ml(:,3),'b-','DisplayName',' sim medium LL');
hold on; h(6)=plot(v+0.1,s_ll(:,3),'g-','DisplayName',' sim low LL');
hold on; h(7)=plot(v,s_hld(:,3),'b--','DisplayName',' sim medium LD');
hold on; h(8)=plot(v+0.1,s_mld(:,3),'g--','DisplayName','sim low LD');


for hh=1:1:length(h)
    h(hh).MarkerSize=10;
    h(hh).LineWidth=1.5;
end

h(1).Marker='*';
h(2).Marker='*';
h(3).Marker='square';
h(4).Marker='square';

%% Figure styling
legend ([h(1) h(6) h(2) h(5) h(3) h(8) h(4) h(7)],'Location','northwest','NumColumns',2);
ylim([0 6])
xlim([0 3.2]); xticks(0:1:3);
xticklabels({'0','1','2','3'});

xlabel ('Trough-to-trough distance (d)');
ylabel ('Trough-to-trough variance');

%% Saving
cd([selpath, '/figures/fig4']);
fname='fig4B';
fig_save_font_20;
