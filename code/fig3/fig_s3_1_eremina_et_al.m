close all;
clearvars -except selpath;

%% 
cd([selpath, '/data/datasets/WT_Ab_medium_LL']);

MY=readmatrix('WT-Ab_mother_mean_fluor.csv');

MY=MY-300; %background subtraction

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-Ab_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

%% Plotting 
figure; subplot(2,1,1);
patch_universal(time_adjusted,'night',MY_smooth,1,[0 4000]);
hold on; 
text(-10, 4000*0.9,strcat('n=',num2str(surv(2))));

st=find(time_adjusted(:,1)==0);

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)= [0.4940 0.1840 0.5560];
    hL(ii).Color(4) = 0.6;
end

hold on; 
h(1)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'m','LineWidth',2,'DisplayName','representative lineage');
legend(h(1));

xticks(0:24:144);
yticks(500:1000:3500);
xlim([-12 144]);
ylim([0 4000])

xlabel('Time (h)');
ylabel('Fluorescence (a.u.)')

%% Adding autocovariance panel

cd([selpath, '/data/meanautocovariance']);

ACV=readmatrix('autocov_WT-Ab [LL].csv');

%autocov -> ACF
ACV(:,2)=ACV(:,2)./max(ACV(:,2));

hold on; %plotting average
subplot(2,1,2)
p1=plot(ACV(:,1),ACV(:,2),'m'); hold on

p1.LineWidth=3;
ylim([-1.5 1.5]);

xticks(-72:24:72); %xtickangle(45)
xlim([- 72 72])

xlabel('Lag (h)')
ylabel('Autocorrelation')


%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s3_1';
fig_save_font_20;