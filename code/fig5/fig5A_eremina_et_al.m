close all;
clearvars -except selpath;


%% Noisy day start
cd([selpath, '/data/datasets/noisy_day_start']);
MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

intensity=readmatrix('WT_light_intensity.csv');
time_l{1,1}=readmatrix('WT_time_light_adjusted.csv');

intensity2=(intensity/(max(intensity)/max((max(MY)))))*1.5; %adjusting light intesity for visualisation purposes

h=figure(1); subplot(2,1,1)
plot(time_l{1,1},intensity2)
h.Position=[100 500 560 420];
hh=area(time_l{1,1},intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([24,48,72,96]); %expected LD interface
vline([24+2.77, 48+2.83, 72-0.18, 96+2.17],'y'); %received LD interface

hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);
yl(2)=max(intensity2);
GR.m_cell_num(1)=surv(2);
hold on; text (-10,yl(2)*0.6,strcat('n=',num2str(GR.m_cell_num(1))));

xticks(0:12:144); xtickangle(45);
xlim([-12 120]);


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

hold on;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(4) = 0;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));
hold on;
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

hold on;
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
hold on;
h(1)=fill(x2, inBetween, 'm','DisplayName','\sigma');
set(h(1),'facealpha',.3);

hold on; 
h(2)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'m','LineWidth',2,'DisplayName',sprintf('representative \n lineage'));

text(24, 0.7*max(intensity2),'\leftarrow expected ');
text(51, 0.55*max(intensity2),'\leftarrow received');

ylim([0 max(intensity2)*0.76])
yticks(0:150:600)

title('Noisy day start');


%% Noisy day end
cd([selpath, '/data/datasets/noisy_day_end']);

t_light_int_h=readmatrix('WT_time_light_adjusted.csv');
intensity=readmatrix('WT_light_intensity.csv');

MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

time_adjusted1=readmatrix('WT_time_adjusted.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end


intensity2=(intensity/(max(intensity)/max((max(MY)))))*1.4; %adjusting light intesity for visualisation purposes
t_light_int_h=t_light_int_h-t_light_int_h(367);

h=figure(1); subplot(2,1,2)
plot(t_light_int_h,intensity2); xticks(0:12:120); xtickangle(45);
h.Position=[100 500 560 420];
hh=area(t_light_int_h,intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([12,36,60,84,108]); %expected LD interface
vline([12+2.77, 36+1.07, 60+2.77, 84+3.53, 108+1.6],'y'); %received LD interface

hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);
yl(2)=max(intensity2);

GR.m_cell_num(2)=surv(2);
hold on; text (-10,yl(2)*0.6,strcat('n=',num2str(GR.m_cell_num(2))));

xticks(0:12:120); xtickangle(45);
xlim([-12 120]);

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

hold on;
for ii=1:size(surv,2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(4) = 0;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on;
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

hold on;
curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
hold on;
h(1)=fill(x2, inBetween, 'm','DisplayName','\sigma');
set(h(1),'facealpha',.3);

hold on; 
h(2)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'m','LineWidth',2,'DisplayName','representative lineage');

yticks(750:750:3550)
ylim([200 max(intensity2)*0.76])

l=legend([h(2) h(1)],'NumColumns',2);
title('Noisy day end');


%% Figure styling

han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');
xlabel(han,'Time (h)');

y1=han.YLabel.Position;
y1(1)=y1(1)*2.2;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig5']);
fname='fig5A';
fig_save_font_20_ssf;

