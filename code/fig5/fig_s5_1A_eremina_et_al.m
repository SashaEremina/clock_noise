close all;
clearvars -except selpath;

%% Part 1 - noisy day start 

cd([selpath, '/data/datasets/noisy_day_start']);

MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-200;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

intensity=readmatrix('WT_light_intensity.csv');
time_l{1,1}=readmatrix('WT_time_light_adjusted.csv');

intensity2=intensity*24/max(intensity); %adjusting light intensity - for visualisation purposes only 

h=figure(1); subplot(2,1,1)
plot(time_l{1,1},intensity2)
h.Position=[100 500 560 420];
hh=area(time_l{1,1},intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([24,48,72,96]); %L/D interface expected
vline([24+2.77, 48+2.83, 72-0.18, 96+2.17],'y'); %L/D interface received

hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);
yl(2)=max(intensity2);

ylim([0 max(intensity2)*1.1]);
yticks(0:5:25);

xticks(0:12:120);
xlim([-12 122]);

text(24, 0.9*max(intensity2),'$\leftarrow$ expected ');
text(48+2.83,0.65*max(intensity2),'$\leftarrow$ received');

title('Noisy day start');


% Marking the day starts
p=diff(find(intensity==0));
ii=find(p>1);
pp=find(intensity==0);
t=time_l{1,1};
is=t(pp(ii));
is(1)=0; %time points of day start to be marked

for i=1:length(is)
    if rem(is(i),24)<10
        text(is(i),5,strcat('+',num2str(round(rem(is(i),24),2)),{' '},'h'));
    else
        text(is(i),5,strcat('-',num2str(round(10-(rem(is(i),24)-14),2)),{' '},'h'));
    end
end

box off
ylim([0 24])

%% Part 2 - noisy day end
clearvars -except selpath;
cd([selpath, '/data/datasets/noisy_day_end']);

t_light_int_h=readmatrix('WT_time_light_adjusted.csv');
intensity=readmatrix('WT_light_intensity.csv');

MY=readmatrix('WT_mother_mean_fluor.csv');
time_adjusted=readmatrix('WT_time_adjusted.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 


%background subtraction
MY=MY-200;

intensity2=intensity*24/max(intensity);  %adjusting light intensity - for visualisation purposes only 

h=figure(1); subplot(2,1,2)
plot(t_light_int_h,intensity2); xticks(0:12:120);
h.Position=[100 500 560 420];
hh=area(t_light_int_h,intensity2,'FaceColor','y','EdgeColor','y');
hh.FaceAlpha=0.3;

vline([12,36,60,84,108]); %L/D interface expected
vline([12+2.77, 36+1.07, 60+2.77, 84+3.53, 108+1.6],'y'); %L/D interface received

text(60, 0.9*max(intensity2),'$\leftarrow$ expected ');
text(84+3.53, 0.7*max(intensity2),'$\leftarrow$ received');


hold on; patch([-12 -12 0 0], [min(intensity2) max(intensity2) max(intensity2) min(intensity2)], 'b'); alpha(0.1);
yl(2)=max(intensity2);

xticks(0:12:120);
xlim([-12 122]);

yticks(0:5:25)
ylim([0 max(intensity2)*1.1])

title('Noisy day end');

box off
ylim([0 24])


%% Marking the day ends

p=find(diff(intensity)<0);
t=t_light_int_h;
is=t(p);
is(end)=[];
is(1)=[]; %time points of day start to be marked

for i=1:length(is)
    if rem(is(i),24)==0
       text(is(i),5,strcat('+',num2str(round(rem(is(i),24),2)),{' '},'h'));

    else
        text(is(i),5,strcat('+',num2str(round(rem(is(i),24)-10,2)),{' '},'h'));
    end
end

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
cd([selpath,'/figures/fig5']);
fname='fig_s5_1A';
fig_save_font_20;


