close all;
clearvars -except selpath;

%% WT
cd([selpath, '/data/datasets/WT_high_LL']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');
time_adjusted=readmatrix('WT-reporter_time_adjusted.csv');

surv=find(all(isnan(MY),1), 1 )-1; %number of cells

%background subtraction
MY=MY-200;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end

yl=[0 700];

figure(1); 
subplot(3,2,1); patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:600);
xlim([-12 120]); xticks(0:24:144);
ylim([0 700]); xlim([-12 106]);

h(2)=plot(time_adjusted(st:end),MY_smooth(st:157,12),'b','LineWidth',2,'DisplayName','Representative lineage'); 
MY_a=mean(MY','omitnan');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
m_cell_num(1)=surv;
h(3)=plot(time_adjusted(st:end),MY_smooth(st:157,42),'k','LineWidth',2,'DisplayName','Representative lineage');
hold on; h(4)=plot(time_adjusted(start_p:end),MY_a(start_p:157),'LineWidth',2,'Color','m','DisplayName','Mean');
title('WT high LL'); set(gca,'Fontsize', 9);

a=xlim;
text(a(2)*0.6,yl(2)*0.9,strcat('n=',num2str(m_cell_num(1))));

%% 2 KaiC-R215C

cd([selpath, '/data/datasets/KaiC-R215C_high_LL_rep1']);

MY=readmatrix('KaiC-R215C_mother_mean_fluor.csv');
time_adjusted=readmatrix('KaiC-R215C_time_adjusted.csv');
surv=find(all(isnan(MY),1), 1 )-1; %number of cells

%background subtraction
MY=MY-200;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


yl=[0 400];

figure(1); 
subplot(3,2,3);
patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
xlim([-12 106]); xticks(0:24:106);

hold on; 
ii=ceil(find(MY==nanmax(MY(116,:)))/300);
h(2)=plot(time_adjusted(st:end),MY_smooth(st:157,ii),'b','LineWidth',2,'DisplayName','Representative lineage');
MY_a=mean(MY','omitnan');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
h(3)=plot(time_adjusted(st:end),MY_smooth(st:157,3),'k','LineWidth',2,'DisplayName','Representative lineage');
m_cell_num(2)=surv;
hold on; h(4)=plot(time_adjusted(start_p:end),MY_a(start_p:157),'LineWidth',2,'Color','m','DisplayName','Mean');
h(5) = plot(NaN,NaN,'LineStyle','none','DisplayName',strcat('n=',num2str(m_cell_num(2))));

title('KaiC-R215C high LL'); set(gca,'Fontsize', 9);
ylim([100 400])
yticks(0:100:400)

a=xlim;
text(a(2)*0.6,yl(2)*0.9,strcat('n=',num2str(m_cell_num(2))));


%% 3 KaiC-T495A

cd([selpath, '/data/datasets/KaiC-T495A_high_LL_rep1']);

MY=readmatrix('KaiC-T495A_mother_mean_fluor.csv');
time_adjusted=readmatrix('KaiC-T495A_time_adjusted.csv');

surv=find(all(isnan(MY),1), 1 )-1; %number of cells

%background subtraction
MY=MY-200;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


yl=[0 400];

figure(1); subplot(3,2,5); 
patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
xlim([-12 106]); xticks(0:24:144); 

hold on; 

h(2)=plot(time_adjusted(st:end),MY_smooth(st:157,12),'b','LineWidth',2,'DisplayName','Representative lineage');
MY_a=mean(MY','omitnan');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
h(3)=plot(time_adjusted(st:end),MY_smooth(st:157,42),'k','LineWidth',2,'DisplayName','Representative lineage');
m_cell_num(3)=surv;
hold on; h(4)=plot(time_adjusted(start_p:end),MY_a(start_p:157),'LineWidth',2,'Color','m','DisplayName','Mean');
h(5) = plot(NaN,NaN,'LineStyle','none','DisplayName',strcat('n=',num2str(m_cell_num(3))));
title('KaiC-T495A high LL'); set(gca,'Fontsize', 9);

ylim([100 400]);
yticks(0:100:400)

a=xlim;
text(a(2)*0.6,yl(2)*0.9,strcat('n=',num2str(m_cell_num(3))));

%% SP16

cd([selpath, '/data/datasets/KaiC-R393C_med_LL_rep2']);

MY=readmatrix('SP16_2_mother_mean_fluor.csv');
time_adjusted=readmatrix('SP16_2_time_adjusted.csv');

surv=find(all(isnan(MY),1), 1 )-1; %number of cells

%background subtraction
MY=MY-300;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


yl=[150 1800];
figure(1); subplot(3,2,6); 
yticks(600:600:1800);
xlim([0 106]); 
xticks(0:16:max(max(time_adjusted)));
ylim([300 1800]);

hold on; 
h(2)=plot(time_adjusted(st:end),MY_smooth(st:160,30),'b','LineWidth',2,'DisplayName','Representative lineage');
MY_a=mean(MY','omitnan');

t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
m_cell_num(4)=surv;
h(3)=plot(time_adjusted(st:end),MY_smooth(st:160,7),'k','LineWidth',2,'DisplayName','Representative lineage'); %'WT Lineage'
hold on; h(4)=plot(time_adjusted(start_p:end),MY_a(start_p:160),'LineWidth',2,'Color','m','DisplayName','Mean');
h(5) = plot(NaN,NaN,'LineStyle','none','DisplayName',strcat('n=',num2str(m_cell_num(4))));
title('SP16 medium LL'); set(gca,'Fontsize', 9);

a=xlim;
text(a(2)*0.6,yl(2)*0.9,strcat('n=',num2str(m_cell_num(4))));


%% LP48

cd([selpath, '/data/datasets/KaiC-A251V_med_LL']);

MY=readmatrix('LP48_mother_mean_fluor.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

%background subtraction
MY=MY-300;


time_adjusted1=readmatrix('LP48_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

time_adjusted=time_adjusted+24;
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


yl=[0 2800];
figure(1); subplot(3,2,4); 
yticks(200:1000:2200);
xlim([0 106]); 
xticks(0:16:max(max(time_adjusted)));
ylim([0 2800]);


hold on; 
h(2)=plot(time_adjusted(st:end,4),MY_smooth(st:end,4),'b','LineWidth',2,'DisplayName','Representative lineage');
MY_a=mean(MY','omitnan');

t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));

h(3)=plot(time_adjusted(st:end,51),MY_smooth(st:end,51),'k','LineWidth',2,'DisplayName','Representative lineage');
m_cell_num(5)=surv(2);
hold on; h(4)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',2,'Color','m','DisplayName','Mean');
h(5) = plot(NaN,NaN,'LineStyle','none','DisplayName',strcat('n=',num2str(m_cell_num(5))));
title('LP48 medium LL'); set(gca,'Fontsize', 9);

a=xlim;
text(a(2)*0.6,yl(2)*0.9,strcat('n=',num2str(m_cell_num(5))));

ylim([0 2800]);

%% legend in position of subplot 6

lgd=legend(h(2:4));
lgd.Position(1)=0.57;
lgd.Position(2)=0.77;

%% Figure styling

figure(1); hold on;
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel(han,'Time (h)');
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig3A';
fig_save_font_20;
