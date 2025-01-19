close all;
clearvars -except selpath;
 
%% low light
subplot(2,1,1);
title('low LL');

cd([selpath, '/data/datasets/WT_low_LL']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');

MY=MY-300; %background subtraction

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

patch_universal_paper(time_adjusted,'night',MY_smooth,1,[0 4000]);
hold on; text(-10, 4000*0.9,strcat('n=',num2str(surv(2))));

st=find(time_adjusted(:,1)==0);

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'g'); hold on
    hL(ii).Color(4) = 0.3;
end

hold on; 

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));

hold on; 
h(2)=plot(time_adjusted(st:end,26),MY_smooth(st:end,26),'k','LineWidth',1,'DisplayName','representative lineage');

xticks(0:24:144);
yticks(0:1000:4000);

xlim([-12 120]);

legend(h(2));

%% high light
subplot(2,1,2); 
title('high LL');

cd([selpath, '/data/datasets/WT_high_LL']);

MY=readmatrix('WT-reporter_mother_mean_fluor.csv');

MY=MY-200; %background subtraction

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

patch_universal_paper(time_adjusted,'night',MY_smooth,1,[0 1000]);
hold on; text(-10, 1000*0.9,strcat('n=',num2str(surv(2))));

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=1;
end

clear hL

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii),'m'); hold on
    hL(ii).Color(4) = 0.3;
end

hold on; 

l=min(unique(ceil(find(time_adjusted==max(max(time_adjusted)))/300)));


hold on; 
h(2)=plot(time_adjusted(st:end,11),MY_smooth(st:end,11),'k','LineWidth',1,'DisplayName','representative lineage');

legend(h(2));

xticks(0:24:144);
yticks(0:250:1000);
xlim([-12 120]);

%% figure design
figure(1); hold on;
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel(han,'Time (h)');
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');

y1=han.YLabel.Position;
y1(1)=y1(1)*2;
han.YLabel.Position=y1;

%% Saving 
cd([selpath,'/figures/fig1']);
fname='fig_s1_3';
fig_save_font_22;

