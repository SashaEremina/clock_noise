close all;
clearvars -except selpath;

%% Part 1 - Caribbean 1

%load the fluorescence data
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
int=(int*19.7);

time_light2=readmatrix('WT_time_light_adjusted.csv');
time_light2=time_light2+(abs(time_light2(86))+abs(time_light2(87)));

k=(max(int)/max((max(MY))*0.6)); %adjusting the light intensity - for visualisation purposes only

%plot the light intensities

figure; 
subplot(2,1,1);

hold on; 
patch([-12 -12 0 0], [0 max(int/k)*2.4 max(int/k)*2.4 0], 'b'); ylim([0 1200]);
alpha(0.15);

A=area(time_light2, int/k);
A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

%plot the fluorescence data
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=8;

hold on; 
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'m'); hold on
    hL(ii).Color(4) = 0.3;
end

hold on; 
h(2)=plot(time_adjusted(st:end,16),MY_smooth(st:end,16),'k','LineWidth',2,'DisplayName',sprintf('representative \n lineage')); %'WT individual lineage'

xlim([- 12 120]); 
ylim([0 850]); yticks(0:250:750);
xticks(0:12:124);

GR.m_cell_num(2)=size(surv,2);
hold on; text (-10,850*0.88,strcat('n=',num2str(surv(2))));

title('Caribbean 1');

%% Part 2 - Caribbean 2 
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

time_light2=time_light2+(abs(time_light2(80))+abs(time_light2(81)));

int=readmatrix('WT-reporter_light_intensity.csv');

k=(max(int)/max((max(MY))*0.6)); %scaling has to be roughly comparable to the one in Caribbean 1 (for visualisation only) 


hold on;
subplot(2,1,2);

hold on; 
patch([-12 -12 0 0], [0 max(int/k)*2 max(int/k)*2 0], 'b'); ylim([0 1200])
alpha(0.15); 

hold on;
A=area(time_light2, int/k);

A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;

%plot the fluorescence data
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=8;

%data crop
MY_smooth=MY_smooth(1:67,:);%cutting the experiment to LD part only
time_adjusted=time_adjusted(1:67,:);%cutting the experiment to LD part only

hold on; 
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'m'); hold on
    hL(ii).Color(4) = 0.3;
end

hold on; 
h(2)=plot(time_adjusted(st:end,20),MY_smooth(st:end,20),'k','LineWidth',2,'DisplayName','representative lineage');

xlim([-12 120]); 
ylim([0 850]); yticks(0:250:850);
l=legend([h(2)]);
xticks(0:12:120);

title('Caribbean 2');

yl(2)=max(int/k);
GR.m_cell_num(2)=size(surv,2);
hold on; text (-10,850*0.88,strcat('n=',num2str(surv(2))));

%% Fugure styling
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
fname='fig_s6_1B';
fig_save_font_20_box_off;


