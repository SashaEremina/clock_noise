close all;
clearvars -except selpath;

% loading the data - medium LL
cd([selpath, '/data/datasets/wt_med_LL_rep1']);

MY=readmatrix('WT_reporter_mother_mean_fluor.csv'); 
MY=MY-200; %background subtraction
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT_reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=1;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

figure;
for i=1:size(MY,1)
    CV1(i)=getCV(MY(i,:));
end

patch_universal(time_adjusted,'night',CV1,1,[0 1]);

f(1)=plot(time_adjusted(st:end,l),CV1(st:end),'b','Linewidth',2,'DisplayName','medium LL');


%% loading the data - low LL
cd([selpath, '/data/datasets/WT_low_LL']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');
MY=MY-300; %background subtraction
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=1;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

for i=1:size(MY,1)
    CV2(i)=getCV(MY(i,:));
end

hold on; 
f(2)=plot(time_adjusted(st:end,l),CV2(st:end),'g','Linewidth',2,'DisplayName','low LL');

%% loading the data - high LL
cd([selpath, '/data/datasets/WT_high_LL']);
MY=readmatrix('WT-reporter_mother_mean_fluor.csv');
MY=MY-200; %background subtraction
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);

for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=1;
end

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

for i=1:size(MY,1)
    CV3(i)=getCV(MY(i,:));
end

hold on; 
f(3)=plot(time_adjusted(st:end,l),CV3(st:end),'m','Linewidth',2,'DisplayName','high LL');

%% figure styling
ylim([0 0.25]);
xticks(0:24:144);
xlim([-12 120]); ylim([0 0.6])
xlabel('Time (h)');
ylabel ('Variabitlity in gene expression (C.V.)');
legend([f(2) f(1) f(3)], 'NumColumns',3);

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig_s1_5';
fig_save_font_20;