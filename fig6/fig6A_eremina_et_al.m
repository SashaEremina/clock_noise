close all;
clearvars -except selpath;

%% Caribbean 1 - top panel

cd([selpath, '/data/datasets/caribbean_1']);

MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

int=readmatrix('WT_light_intensity.csv');
time_light2=readmatrix('WT_time_light_adjusted.csv');


k=(max(int))/max((max(MY))*0.6); %light intensity adjustment coefficient - for visualisation only


hold on;
subplot(2,1,1);
patch([-12 -12 0 0], [0 max(int/k)*2 max(int/k)*2 0], 'b'); ylim([0 750])
alpha(0.15);

hold on;
A=area(time_light2, int/k);

A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1);
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=8;

y=mean(MY_smooth','omitnan');
y=y(st:end);

std_dev=std(MY_smooth','omitnan');
std_dev=std_dev(st:end);

a=max(max(time_adjusted));
x=time_adjusted(st:end,ceil(find(time_adjusted==a, 1 )/300))';

keepIndex = ~isnan(y) & ~isnan(std_dev) & ~isnan(x);
y=y(keepIndex);
std_dev=std_dev(keepIndex);
x=x(keepIndex);

curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
hold on;
h(1)=fill(x2, inBetween, 'm','DisplayName','$\sigma$'); 
set(h(1),'facealpha',.3);

hold on; 
h(2)=plot(time_adjusted(st:end,16),MY_smooth(st:end,16),'m','LineWidth',2,'DisplayName',sprintf('Representative \n lineage'));

xlim([- 12 120]); ylim([0 750]); yticks(0:250:750)
xticks(0:24:120); 
GR.m_cell_num(2)=surv(2);
hold on; text (-10,750*0.88,strcat('n=',num2str(GR.m_cell_num(2))));

% Figure styling, top panel
title('Caribbean 1');
yyaxis right; yticks(0:0.2:1);
yticklabels({'0','15','30','45','60','75'}); %approx - for visualisation only
ax = gca;
ax.YColor='k';

%% Caribbean 2 - bottom panel
clearvars -except selpath; 

%load the fluorescence data
cd([selpath, '/data/datasets/caribbean_2']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

%background subtraction
MY=MY-300;

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

time_light2=readmatrix('WT-reporter_time_light_adjusted.csv');
int=readmatrix('WT-reporter_light_intensity.csv');

k=(max(int)/max((max(MY))*0.8)); 

hold on;
subplot(2,1,2);

hold on; 
patch([-12 -12 0 0], [0 max(int/k)*2 max(int/k)*2 0], 'b'); ylim([0 750])
alpha(0.15);

hold on;
A=area(time_light2, int/k);

A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1);
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=8;
y=mean(MY_smooth','omitnan');
y=y(st:end);

std_dev=std(MY_smooth','omitnan');
std_dev=std_dev(st:end);

a=max(max(time_adjusted));
x=time_adjusted(st:end,ceil(find(time_adjusted==a, 1 )/300))';

keepIndex = ~isnan(y) & ~isnan(std_dev) & ~isnan(x);
y=y(keepIndex);
std_dev=std_dev(keepIndex);
x=x(keepIndex);

curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
hold on;
h(1)=fill(x2, inBetween, 'm','DisplayName','$\sigma$'); 
set(h(1),'facealpha',.3);

hold on; 
h(2)=plot(time_adjusted(st:end,20),MY_smooth(st:end,20),'m','LineWidth',2,'DisplayName','Representative lineage');

%Figure styling, botom panel
xlim([-12 120]); xticks(0:24:120); 
ylim([0 750]); yticks(0:250:750)
l=legend([h(2) h(1)],'NumColumns',2);
l.Position(2)=l.Position(2)*0.95;
l.Position(1)=l.Position(1)*0.9;

title('Caribbean 2');

yl(2)=max(int/k);
GR.m_cell_num(2)=surv(2);
hold on; text (-10,750*0.88,strcat('n=',num2str(GR.m_cell_num(2))));

yyaxis right; yticks(0:0.2:0.9);
yticklabels({'0','20','40','60','80'});
ylabel({'Light intensity ($\mu$mol $m^{-2}$ $s^{-1}$)'}); %have to manually center the label
ax = gca;
ax.YColor='k';


%% Figure styling - x2 panels combined 
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');
xlabel(han,'Time (h)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig6']);
fname='fig6A';
fig_save_font_20;

