close all;
clearvars -except selpath;

%% Pt 1 - top panel 

%%LD medium
cd([selpath, '/data/datasets/WT_med_LD']);

MY=readmatrix('WT_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(4) = 0;
end

subplot(2,1,1);

patch_universal(time_adjusted,'day',MY_smooth,1,[0 1500]);
hold on; 

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on; 

y=nanmean(MY_smooth');
y=y(st:end);

std_dev=nanstd(MY_smooth');
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
h(1)=fill(x2, inBetween, 'b','DisplayName','$\sigma$ medium LD');
set(h(1),'facealpha',.3);

hold on; 

%mean trace
y=nanmean(MY_smooth');
std_dev=nanstd(MY_smooth');
l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));
x=time_adjusted(:,l)';
h(2)=plot(x(st:end), y(st:end), 'b', 'LineWidth', 2,'DisplayName','mean medium LD');

yl(2)=1000;
GR.m_cell_num(1)=surv(2);
hold on; text (0,yl(2)*0.8,strcat('n medium LD = ',{' '},num2str(GR.m_cell_num(1))));



%% LD low intensity
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

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(4) = 0;
end

hold on; 

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

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
h(3)=fill(x2, inBetween, 'g','DisplayName','$\sigma$ low LD');
set(h(3),'facealpha',.3);

hold on; 
%mean trace
y=mean(MY','omitnan');
std_dev=std(MY','omitnan');
l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));
x=time_adjusted(:,l)';
h(4)=plot(x(st:end), y(st:end), 'g', 'LineWidth', 2,'DisplayName','mean low LD'); % $\ $ $\ $ $\ $ $\ $

yl(2)=1000;
GR.m_cell_num(1)=surv(2);
hold on; text (0,yl(2)*0.95,strcat('n low LD = ',{' '},num2str(GR.m_cell_num(1))));

%% Figure styling
legend([h(3) h(4) h(1) h(2)],'Location','BestOutside');
xticks(0:24:144); 
xlim([-12 120]);
ylim([0 1100]); yticks(0:250:1000);
title('Clock reporter expression');
xlabel('Time (h)');
ylabel({'Fluorescence (a.u.)'});


%% Pt 2 - bottom panel, simulations
cd([selpath, '/simulations/traces_Fig3']);

%LD low
D=dir('*LDtrace.low*');

dd=readmatrix(D(1).name);
Ti=NaN(length(dd),length(D)); %time vectors
Tr=NaN(length(dd),length(D)); %traces

for i=1:length(D)
    dd=readmatrix(D(i).name);
    Ti(:,i)=dd(:,1);
    Tr(:,i)=dd(:,2); %phosphostatus
end

%background shading
hold on; subplot(2,1,2);
yl=[0 max(dd(:,2)*10)];
patch_universal(dd(:,1),'day',dd(:,2),1,yl);

hold on; plot(Ti, Tr,'Color',[0.45 0.9 0.15 0.5]);
t(1)=plot(Ti(:,1),Tr(:,1),'Color',[0.45 0.9 0.15 0.5],'LineWidth',2,'DisplayName','low LD $\ $ $\ $ $\ $');

xlim([-12 120])
xticks(0:24:120);
ylim([0 0.5]);
yticks(0:0.1:0.5);

xlabel('Time (h)');
title ('Simulations');


% LD med
D=dir('*LDtrace.medium*');

dd=readmatrix(D(1).name);
Ti=NaN(length(dd),length(D)); %time vectors
Tr=NaN(length(dd),length(D)); %traces

for i=1:length(D)
    dd=readmatrix(D(i).name);
    Ti(:,i)=dd(:,1);
    Tr(:,i)=dd(:,2); %phosohostatus
end

hold on; h=plot(Ti, Tr,'Color',[0.2 0.5 0.9 0.5]);
t(2)=plot(Ti(:,1),Tr(:,1),'Color',[0.2 0.5 0.9 0.5],'LineWidth',2,'DisplayName','medium LD $\ $');

%mock plot for legend
t(1)=plot(NaN,NaN,'Color',[0.45 0.9 0.15 0.5],'LineWidth',4,'DisplayName','low LD');
t(2)=plot(NaN,NaN,'Color',[0.2 0.5 0.9 0.5],'LineWidth',4,'DisplayName','medium LD'); 

%% Figure styling
legend ([t(1) t(2)],{'low LD',sprintf('medium \n LD')},'Location','BestOutside')

ylabel({'KaiC-P (normalised)'}); 
ylim([0.1 0.4]); yticks(0.1:0.1:0.4);

%MANUAL ADJUSTMENTS TO FIG.SIZE

%% Saving
cd([selpath,'/figures/fig4']);
fname='fig4A';
fig_save_font_20;
