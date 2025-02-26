close all;
clearvars -except selpath;

%% Loading the data

cd([selpath, '/simulations/p2pStatistics/noisyenvironments_Fig6']);
ndc1_sim=readmatrix('LDsim_carr1.csv');
ndc2_sim=readmatrix('LDsim_carr2.csv');

ndc1_exp=readmatrix('LDexp_carr1.csv');
ndc2_exp=readmatrix('LDexp_carr2.csv');

%% Plotting

figure; 
v=[1 2 3 4 5];
hold on;
subplot(2,1,1); 
p(3)=errorbar(v+0.05,ndc1_sim(:,1),ndc1_sim(:,1).*ndc1_sim(:,2),'ob','LineWidth',1); hold on;
dd(3)=errorbar(v-0.05,ndc1_exp(:,1),ndc1_exp(:,1).*ndc1_exp(:,2),'om','LineWidth',1); hold on;
%xlabel('Day ($\#$)'); 
ylim([3 7]); yticks(4:1:8); xlim([0.1 5.5]); xticks(1:5);
title('Caribbean 1');

xlim([0.8 5.5]);
hold on;
subplot(2,1,2); 
p(4)=errorbar(v(1:4)'+0.05,ndc2_sim(:,1),ndc2_sim(:,1).*ndc2_sim(:,2),'ob','LineWidth',1); hold on;
dd(4)=errorbar(v(1:4)'-0.05,ndc2_exp(:,1),ndc2_exp(:,1).*ndc2_exp(:,2),'om','LineWidth',1); hold on;
xlabel('Day (#)'); 
ylim([3 7]); yticks(4:1:8); xlim([0.1 5.5]); xticks(1:4);
title('Caribbean 2');

xlim([0.8 5.5]);

for pp=3:4
    p(pp).MarkerSize=4; p(pp).MarkerFaceColor=p(pp).MarkerEdgeColor;
    dd(pp).MarkerSize=4; dd(pp).MarkerFaceColor=dd(pp).MarkerEdgeColor;
end

legend({'simulation', 'experiment'},'Location','SouthEast')

%% Figure styling
ax = axes(figure (1));
han = gca;
han.Visible = 'off';

ylabel('Mean trough time (h)')
han.YLabel.Visible = 'on';

%% Saving
cd([selpath,'/figures/fig6']);
fname='fig6B';
fig_save_font_20_box_on_ssf;

