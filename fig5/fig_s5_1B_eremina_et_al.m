close all;
clearvars -except selpath;

%% Pt 1 - noisy day start
cd([selpath, '/data/datasets/noisy_day_start']);

MY=readmatrix('WT_mother_mean_fluor.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

%background subtraction
MY=MY-300;

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

intensity=readmatrix('WT_light_intensity.csv');
time_l{1,1}=readmatrix('WT_time_light_adjusted.csv');

intensity2=(intensity/(max(intensity)/max((max(MY)))))*1.5; %adjusting light intensity -- for visualisation purposes only

h=figure(1); subplot(2,1,1)
plot(time_l{1,1},intensity2)
h.Position=[100 500 560 420];
hh=area(time_l{1,1},intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([24,48,72,96]); %L/D interface expected
vline([24+2.77, 48+2.83, 72-0.18, 96+2.17],'y'); % L/D interface received

hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);
yl(2)=max(intensity2);
GR.m_cell_num(1)=surv(2);
hold on; text (-10,yl(2)*0.7,strcat('n=',num2str(GR.m_cell_num(1))));

xticks(0:12:144);
xlim([-12 120]);

% Plotting fluorescence
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

hold on;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'m'); hold on
    hL(ii).Color(4) = 0.3;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on; 
h(1)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'k','LineWidth',2,'DisplayName','representative lineage');

text(24, 0.75*max(intensity2),'$\leftarrow$ expected ');
text(24+2.83,0.65*max(intensity2),'$\leftarrow$ received');

ylim([0 max(intensity2)*0.85])
yticks(0:250:1250);
legend([h(1)],'Location','NorthEast');
title('Noisy day start');

%% Part 2 - noisy day end
clearvars -except selpath;
cd([selpath, '/data/datasets/noisy_day_end']);

t_light_int_h=readmatrix('WT_time_light_adjusted.csv');
intensity=readmatrix('WT_light_intensity.csv');

MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);

for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

intensity2=(intensity/(max(intensity)/max((max(MY)))))*1.2; %adjusting light intensity -- for visualisation purposes only
t_light_int_h=t_light_int_h-t_light_int_h(367);

h=figure(1); subplot(2,1,2)
plot(t_light_int_h,intensity2); xticks(0:12:120);
h.Position=[100 500 560 420];
hh=area(t_light_int_h,intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([12,36,60,84,108]); %L/D interface expected
vline([12+2.77, 36+1.07, 60+2.77, 84+3.53, 108+1.6],'y'); % L/D interface received

text(36, 0.08*max(intensity2),'$\leftarrow$ expected ');
text(84+3.53, 0.08*max(intensity2),'$\leftarrow$ received');


hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);

yl(2)=max(intensity2);
GR.m_cell_num(2)=surv(2);
hold on; text (-10,yl(2)*0.7,strcat('n=',num2str(GR.m_cell_num(2))));

xticks(0:12:120);
xlim([-12 120]);

% Plotting fluorescence
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

hold on;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'m'); hold on
    hL(ii).Color(4) = 0.3;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on;
h(2)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'k','LineWidth',2,'DisplayName','representative lineage');
yticks(0:1000:3000)

ylim([0 max(intensity2)*0.85])

title('Noisy day end');


%% Figure styling

han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');
xlabel(han,'Time (h)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig5']);
fname='fig_s5_1B';
fig_save_font_20;
