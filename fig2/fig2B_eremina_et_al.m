close all; clear all

%% load the data - robustness
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\robustness']);

prkE=readmatrix('robustness_ΔprkE [LL].csv');
prkE(19,:)=[]; %removing the sick cell;

pex=readmatrix('robustness_Δpex [LL].csv');
ldpA=readmatrix('robustness_ΔldpA [LL].csv');
lalA=readmatrix('robustness_ΔlalA [LL].csv');
WT=readmatrix('robustness_WT (ΔlalA) [LL].csv');

%% For cell count
w1=[ldpA(:,1)']; %del_ldpA
w2=[pex(:,1)']; %del_pex
w3=[prkE(:,1)']; %del_prkE
w4=[lalA(:,1)']; %del_lalA
w5=[WT(:,1)']; %WT

%establishing a color palette
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];
cp=cp./255;


%% 1. WT

%load the data
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\wt_med_LL_rep2']);
MY=readmatrix('29-Mar-2022_WT-reporter_mother_mean_fluor.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('29-Mar-2022_WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

%background subtraction
MY=MY-200; 

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p)
    start_p=1;
    st=start_p;
end

yl=[0 700];


figure(1); subplot(3,2,1); yl=[0 700]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:600);
xlim([-12 140]);
xticks(0:24:120);
ylim([0 700]);

clear hL;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color=cp(1,:);
    hL(ii).Color(4) = 0.8;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

MY_a=nanmean(MY');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
hold on; h(1)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',1,'Color','k','DisplayName','Mean');
title('WT'); set(gca,'Fontsize', 9);

m_cell_num(1)=surv(2);
text (-10,yl(2)*0.85,strcat('n=',num2str(surv(2))), 'Interpreter', 'latex');

%% 2 LalA
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\del_lalA_med_LL']);
MY=readmatrix('29-Mar-2022_del_lalA_3_mother_mean_fluor.csv');

%background subtraction
MY=MY-200; 

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('29-Mar-2022_del_lalA_3_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) 
    start_p=1;
    st=start_p;
end

yl=[0 600];

figure(1); subplot(3,2,5); yl=[0 600]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:600);
xlim([-12 140]); 
xticks(0:24:120); 
ylim([0 600]);  

clear hL;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color=cp(5,:);
    hL(ii).Color(4) = 0.8;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

MY_a=nanmean(MY');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
hold on; h(1)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',1,'Color','k','DisplayName','mean');
title('$\Delta$\it lalA'); set(gca,'Fontsize', 9);

m_cell_num(1)=surv(2);
text(-10,yl(2)*0.85,strcat('n=',num2str(m_cell_num(1))), 'Interpreter', 'latex');


%% 3 prkE
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\del_prkE_med_LL']);

MY=readmatrix('30-Jun-2022_del_prkE_mother_mean_fluor.csv');

%background subtraction
MY=MY-200; 

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)-1]; %-1 bc 1 line removed in the code below

time_adjusted1=readmatrix('30-Jun-2022_del_prkE_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

MY(:,19)=[]; %only for this dataset!

%normalisation against wt imaged at similar conditions
%y120_y100_normalisation_paper; %CANNOT DO currently...
%MY=MY.*cn;


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) 
    start_p=1;
    st=start_p;
end



yl=[0 600];
figure(1); subplot(3,2,4); yl=[0 600]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:600);
xlim([-12 140]); 
xticks(0:24:120); 
ylim([0 600]);  

clear hL;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color=cp(4,:);
    hL(ii).Color(4) = 1; 
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

MY_a=nanmean(MY');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
hold on; h(1)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',1,'Color','k','DisplayName','mean');
title('$\Delta$\it prkE'); set(gca,'Fontsize', 9);

m_cell_num(1)=surv(2);
text (-10,yl(2)*0.85,strcat('n=',num2str(m_cell_num(1))), 'Interpreter', 'latex');

lgd=legend([h(1)]);
lgd.Position(2)=lgd.Position(2)*0.95;

%% 4 ldpA
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\del_ldpA_med_LL']);

MY=readmatrix('2020-10-12-del_ldpA_mother_mean_fluor.csv');

%background subtraction
MY=MY-200; 

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('2020-10-12-time_vector.csv');
time_adjusted1=time_adjusted1';
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) 
    start_p=1;
    st=start_p;
end



yl=[0 1000];
figure(1); subplot(3,2,2); yl=[0 1000]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:300:900);
xlim([-12 140]); 
xticks(0:24:120);
ylim([100 1000]);  

clear hL;
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color=cp(2,:);
    hL(ii).Color(4) = 1; 
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

MY_a=nanmean(MY');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
hold on; h(1)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',1,'Color','k','DisplayName','mean');
title('$\Delta$\it ldpA'); set(gca,'Fontsize', 9);

m_cell_num(1)=surv(2);
text (-10,yl(2)*0.85,strcat('n=',num2str(m_cell_num(1))), 'Interpreter', 'latex');

%% 5 pex

cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\del_pex_med_LL']);

MY=readmatrix('2020-11-03-del_pex_mother_mean_fluor.csv');

%background subtraction
MY=MY-200; 

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('2020-11-03-time_vector.csv');
time_adjusted1=time_adjusted1';
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) 
    start_p=1;
    st=start_p;
end

yl=[0 700];
figure(1); subplot(3,2,3); yl=[0 700]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:600);
xlim([-12 140]);
xticks(0:24:120); 
ylim([100 700]);  

clear hL
for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color=cp(3,:);
    hL(ii).Color(4) = 0.8;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

MY_a=nanmean(MY');
t_m=ceil(find(time_adjusted==max(max(time_adjusted)), 1 )/size(time_adjusted,1));
hold on; h(1)=plot(time_adjusted(start_p:end,t_m),MY_a(start_p:end),'LineWidth',1,'Color','k','DisplayName','mean');
title('$\Delta$\it pex');
set(gca,'Fontsize', 9);

m_cell_num(1)=surv(2);
text (-10,yl(2)*0.85,strcat('n=',num2str(m_cell_num(1))), 'Interpreter', 'latex');


%% Legend
subplot(3,2,4);

r=-350;
rr=200;

w5(61:62)=NaN; %filtering the outliers out

text(-15,r,strcat('$\mathrm{p_{WT}}$=', num2str(round(nanmean(w5),1)),'$\pm$',num2str(round(nanstd(w5),1)),'h'));
text(-15,r-4*rr,strcat('$\mathrm{p_{\Delta \it lalA}}$=', num2str(round(nanmean(w4),1)),'$\pm$',num2str(round(nanstd(w4),1)),'h'));
text(-15, r-rr,strcat('$\mathrm{p_{\Delta \it ldpA}}$=', num2str(round(nanmean(w1),1)),'$\pm$',num2str(round(nanstd(w1),1)),'h'));
text(-15, r-2*rr,strcat('$\mathrm{p_{\Delta \it pex}}$=', num2str(round(nanmean(w2),1)),'$\pm$',num2str(round(nanstd(w2),1)),'h'))%,'Interpreter', 'latex')
text(-15,r-3*rr,strcat('$\mathrm{p_{\Delta \it prkE}}$=', num2str(round(nanmean(w3),1)),'$\pm$',num2str(round(nanstd(w3),1)),'h'));


%% Setting fonts etc

figure(1); hold on;
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel(han,'Time (h)');
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%Saving - disabled
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig2']);
fname='fig2B';
fig_save_font_20;

