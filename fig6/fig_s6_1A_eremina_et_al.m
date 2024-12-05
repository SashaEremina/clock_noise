close all;
clearvars -except selpath;

%% Part 1 -- Caribbean 1

cd([selpath, '/data/datasets/caribbean_1']);
int=readmatrix('WT_light_intensity.csv');
int=(int*19.7);

time_light2=readmatrix('WT_time_light_adjusted.csv');
time_light2=time_light2+(abs(time_light2(86))+abs(time_light2(87)));


figure; 
subplot(2,1,1);

hold on; 
patch([-12 -12 0 0], [0 max(int)*1.2 max(int)*1.2 0], 'b'); ylim([0 85])
alpha(0.15); 

A=area(time_light2, int);
A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

xlim([- 12 120]);
xticks(0:12:124)

title('Caribbean 1: Jan $7^{th}$-$12^{th}$, 2017');
%box off

%% Part 2 -- Caribbean 2

cd([selpath, '/data/datasets/caribbean_2']);

int=readmatrix('WT-reporter_light_intensity.csv');
int=int*19.7;

time_light2=readmatrix('WT-reporter_time_light_adjusted.csv');
time_light2=time_light2+(abs(time_light2(80))+abs(time_light2(81)));


%plot the light intensities
hold on;
subplot(2,1,2);

patch([-12 -12 0 0], [0 max(int)*20 max(int)*20 0], 'b'); ylim([0 85])
alpha(0.15);


hold on;
A=area(time_light2, int);
A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

xlim([- 12 120]);
xticks(0:12:124)

title('Caribbean 2: Dec $1^{st}$-$4^{th}$, 2017');
%box off

%% Figure styling

han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';

ylabel(han,'Light intensity ($\mu$mol $m^{-2}$ $s^{-1}$)');

xlabel(han,'Time (h)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig6']);
fname='fig_s6_1A';
fig_save_font_20;
