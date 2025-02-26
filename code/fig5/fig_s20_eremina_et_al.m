close all;
clearvars -except selpath;

%% Setting up a figure layout
figure(1)
subplotLayout = [2,2];
ax = gobjects(fliplr(subplotLayout));
for i = 1:prod(subplotLayout)
    ax(i) = subplot(subplotLayout(1),subplotLayout(2),i);
end
set(ax,'Units','Normalize');
ax = ax';
axPos = cell2mat(get(ax, 'Position'));
axPos(:,4) = axPos(:,4).*.98;
set(ax, {'Position'}, mat2cell(axPos, ones(numel(ax),1), 4));
axPos = cell2mat(get(ax(:,1), 'Position'));
axUpperPos = sum(axPos(:,[2,4]),2);  
axPos = cell2mat(get(ax(1,[1,end]),'Position'));
axCenterPos = mean([axPos(1,1), sum(axPos(2,[1,3]))]);
titles = {'Noisy day start', 'Noisy day end'};  
titleHandles = gobjects(numel(titles),1); 
for i = 1:numel(titles)
    titleHandles = annotation('textbox','String',titles{i}, ...
        'Position', [axCenterPos, axUpperPos(i), 0, 0], ... 
        'HorizontalAlignment', 'center','VerticalAlignment','bottom',...
        'LineStyle','none','FitBoxToText','on', ...
        'FontWeight',ax(1).Title.FontWeight, ... 
        'FontSize', ax(1).Title.FontSize, ...    
        'FontName', ax(1).Title.FontName, ...  
        'Color', ax(1).Title.Color);            
end

%% Loading the data
cd([selpath, '/simulations/p2pStatistics/noisyenvironments_Fig6']);

nde_sim=readmatrix('LDsim_nde.csv'); 
nds_sim=readmatrix('LDsim_nds.csv');

nde_exp=readmatrix('LDexp_nde.csv'); 
nds_exp=readmatrix('LDexp_nds.csv');

%% Plotting, pt 1
hold on;
subplot(2,2,2); 
p(1)=plot(nde_sim(:,1),nde_sim(:,3),'ob', 'MarkerFaceColor','b','DisplayName','simulation'); hold on;
dd(1)=plot(nde_exp(:,1),nde_exp(:,3),'om','MarkerFaceColor','m','DisplayName','experiment'); hold on;
xlabel('Previous day length (h)');
xlim([10 15]); xticks(10:15); xtickangle(45);
ylim([0 0.3]); ylabel({'C.V. (MTT)'});
legend;

hold on;
subplot(2,2,4); 
p(2)=plot(nds_sim(:,1),nds_sim(:,3),'ob','MarkerFaceColor','b','DisplayName','simulation'); hold on;
dd(2)=plot(nds_exp(:,1),nds_exp(:,3),'om','MarkerFaceColor','m','DisplayName','experiment'); hold on;
xlabel('Dawn delay (h)');
xlim([-1 4]); xticks(0:4); xtickangle(45); ylim([0 0.3]);
ylabel({'C.V. (MTT)'});

for pp=1:2
    p(pp).MarkerSize=8; p(pp).MarkerEdgeColor=[0 0 0];
    dd(pp).MarkerSize=8; dd(pp).MarkerEdgeColor=[0 0 0];
end 

%% Plotting, pt 2
v=[1 2 3 4 5];

hold on;
subplot(2,2,1); 
p(1)=errorbar(v+0.07,nde_sim(:,2),nde_sim(:,2).*nde_sim(:,3),'ob','LineWidth',1); hold on;
dd(1)=errorbar(v-0.07,nde_exp(:,2),nde_exp(:,2).*nde_exp(:,3),'om','LineWidth',1); hold on;

p(1).DisplayName='Simulation';
dd(1).DisplayName='Experiment';

xlabel ('Day Number');
ylim([3.5 10]); yticks(4:1:10);
xticks(1:1:5); xtickangle(45); xlim([0.5 5.5]);


hold on;
subplot(2,2,3); 
p(2)=errorbar(v+0.07,nds_sim(:,2),nds_sim(:,2).*nds_sim(:,3),'ob','LineWidth',1); hold on;
dd(2)=errorbar(v-0.07,nds_exp(:,2),nds_exp(:,2).*nds_exp(:,3),'om','LineWidth',1); hold on;

p(2).DisplayName='Simulation';
dd(2).DisplayName='Experiment';

for pp=1:2
    p(pp).MarkerSize=8; 
    dd(pp).MarkerSize=8;
end 

xlabel('Day number');
ylim([3.5 10]); yticks(4:1:10);
xticks(1:1:5); xtickangle(45); xlim([0.5 5.5]); 

%% Figure styling
ax = axes(figure (1));
han = gca;
han.Visible = 'off';

ylabel('Mean trough time, MTT (h)')
han.YLabel.Visible = 'on';

%% Saving
cd([selpath,'/figures/fig5']);
fname='fig_s20';
fig_save_font_18_box_on_ssf;
