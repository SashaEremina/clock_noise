close all;
clearvars -except selpath;

%% 1. LD medium
figure; subplot (2,1,2)

cd([selpath, '/data/datasets/WT_med_LD']);

MY=readmatrix('WT_mother_mean_fluor.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

%background subtraction
MY=MY-300;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'b'); hold on
    hL(ii).Color(4) = 0.1;
end

patch_universal(time_adjusted,'day',MY_smooth,1,[0 1500]);
hold on; 

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on; 
h(1)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'k','LineWidth',2,'DisplayName','representative lineage');

yl(2)=1000;
GR.m_cell_num(1)=surv(2);
hold on; text (-10,yl(2)*0.9,strcat('n = ',{' '},num2str(GR.m_cell_num(1))));

legend(h(1));
ylim([0 1000]); yticks(0:200:1000);
xlim([-12 120]); xticks(0:12:120);

title ('medium LD');

%% 2. LD low
cd([selpath, '/data/datasets/WT_low_LD']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

clear hL

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);


hold on;
subplot(2,1,1);

patch_universal(time_adjusted,'day',MY_smooth,1,[0 1000]); 
hold on; 


for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'g'); hold on
    hL(ii).Color(4) = 0.3;
end

hold on; 
h(2)=plot(time_adjusted(st:end,26),MY_smooth(st:end,26),'k','LineWidth',2,'DisplayName','representative lineage');

yl(2)=1000;
GR.m_cell_num(1)=surv(2);
hold on; text (-10,yl(2)*0.9,strcat('n = ',{' '},num2str(GR.m_cell_num(1))));

ylim([0 1000])

%% Figure styling 
legend(h(2));
ylim([0 1000]); yticks(200:200:1000);
xlim([-12 120]); xticks(0:12:120);
title ('low LD');

han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel(han,'Time (h)');
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath, '/figures/fig4']);
fname='fig_s4_1';
fig_save_font_20;