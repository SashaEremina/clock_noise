close all;
clearvars -except selpath;

%% Pt1: Square and Smooth
%Loading the data
d=[1 2 3 4 5];
cd([selpath, '/simulations/noiseaveraging_SupplFig']);

c1_sm=readmatrix('LDsim_car1_smoothed.csv');
c1_sq=readmatrix('LDsim_car1_square.csv');

c2_sm=readmatrix('LDsim_car2_smoothed.csv');
c2_sq=readmatrix('LDsim_car2_square.csv');

figure(1); subplot (2,1,1); title ('Caribbean 1'); hold on
p(1)=errorbar(d-0.05,c1_sq(:,1),c1_sq(:,1).*c1_sq(:,2),'oy','LineWidth',1,'DisplayName','square'); hold on;
p(2)=errorbar(d+0.05,c1_sm(:,1),c1_sm(:,1).*c1_sm(:,2),'or','LineWidth',1,'DisplayName','smooth'); hold on;

p(1).Color=[0.929 0.694 0.125];
p(2).Color=[0.85 0.325 0.098];

xlim([0.8 5.5]); xticks(1:1:5);
ylim([2.5 8.2]); yticks (4:1:7);

figure(1); subplot (2,1,2); title ('Caribbean 2'); hold on;
p(3)=errorbar(d(1:4)-0.05,c2_sq(:,1),c2_sq(:,1).*c2_sq(:,2),'oy','LineWidth',1, 'DisplayName','square'); hold on;
p(4)=errorbar(d(1:4)+0.05,c2_sm(:,1),c2_sm(:,1).*c2_sm(:,2),'or','LineWidth',1, 'DisplayName','smooth'); hold on;

p(3).Color=[0.929 0.694 0.125];
p(4).Color=[0.85 0.325 0.098];

legend('Location','SouthEast')
xlim([0.8 5.5]); xticks(1:1:5);
ylim([2.5 8.2]); yticks (4:1:7);

%% Part 1 figure styling
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';

ylabel(han,'Mean trough time (h)');
xlabel('Day (#)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%% Part 2:  Natural and Experiment
%Loading the data

cd([selpath, '/simulations/noiseaveraging_SupplFig']);
ndc1_sim=readmatrix('LDsim_carr1.csv');
ndc2_sim=readmatrix('LDsim_carr2.csv');
ndc1_exp=readmatrix('LDexp_carr1.csv');
ndc2_exp=readmatrix('LDexp_carr2.csv');

hold on; 
subplot(2,1,1); box on;

p(5)=errorbar(d+0.12,ndc1_sim(:,1),ndc1_sim(:,1).*ndc1_sim(:,2),'ob','LineWidth',1); hold on;
p(6)=errorbar(d+0.17,ndc1_exp(:,1),ndc1_exp(:,1).*ndc1_exp(:,2),'om','LineWidth',1); hold on;

p(5).Color=[0 0.447 0.741];

hold on;
subplot(2,1,2); box on;

p(7)=errorbar(d(1:4)+0.12,ndc2_sim(:,1),ndc2_sim(:,1).*ndc2_sim(:,2),'ob','LineWidth',1,'DisplayName','natural'); hold on;
p(8)=errorbar(d(1:4)+0.17,ndc2_exp(:,1),ndc2_exp(:,1).*ndc2_exp(:,2),'om','LineWidth',1,'DisplayName','experiment'); hold on;

p(7).Color=[0 0.447 0.741];

l=legend([p(3) p(4) p(7) p(8)], 'NumColumns',4);
ylim([2.5 8]); yticks (4:1:7);

%% Part 2 figure styling
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';

ylabel(han,'Mean trough time (h)');
xlabel('Day (#)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig6']);
fname='fig6D';
fig_save_font_18_box_on_ssf;


