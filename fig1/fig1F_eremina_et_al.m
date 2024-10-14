clearvars -except selpath; 
close all;

%% plot1
cd([selpath, '/data/robustness']);

wt_l1=readmatrix('robustness_WT [low LL].csv'); %low LL
wt_l2=readmatrix('robustness_WT [LL].csv');%medium LL
wt_l3=readmatrix('robustness_WT [high LL].csv');%high LL

w1=wt_l1(:,3);
w2=wt_l2(:,3);
w3=wt_l3(:,3); 

w1=(2./w1)/24;
w2=(2./w2)/24;
w3=(2./w3)/24;

figure(1);
subplot (3,2,1); hold on; hh(1)=histogram(w1,'Normalization','Probability','FaceColor','green','DisplayName','low LL');
title ('Phase');

hh(1).BinWidth=100;
xlim([0 2550]);
xticks(0:750:2500);

subplot (3,2,3); hold on; hh(2)=histogram(w2,'Normalization','Probability','FaceColor','blue','DisplayName','medium LL');
hh(2).BinWidth=100;
xlim([0 2550]);
xticks(0:750:2500);

subplot (3,2,5); hold on; hh(3)=histogram (w3,'Normalization','Probability','FaceColor','magenta','DisplayName','high LL');
hh(3).BinWidth=100;

xlim([0 2550]);
xticks(0:750:2500);

for i=1:3
    hh(i).FaceAlpha=0.2;
end

xlabel('Phase diffusion time (d)');

%% plot2
clearvars -except selpath; 

cd([selpath, '/data/robustness']);

wt_l1=readmatrix('robustness_WT [low LL].csv'); %low LL
wt_l2=readmatrix('robustness_WT [LL].csv'); %medium LL
wt_l3=readmatrix('robustness_WT [high LL].csv'); %high LL


w1=wt_l1(:,2); 
w2=wt_l2(:,2); 
w3=wt_l3(:,2);

%removing outliers - visulasiation purposes
w1=rmoutliers(w1,'percentiles',[4 100]);
w2=rmoutliers(w2,'percentiles',[17 100]);
w3=rmoutliers(w3,'percentiles',[13 100]);

w1=(1./w1)/24;
while max(w1)>1000
    w1(w1==max(w1))=[]; %outlier filter
end
w2=(1./w2)/24;
w3=(1./w3)/24;

figure(1);
hold on; subplot(3,2,2); hold on; hh(1)=histogram(w1,'Normalization','Probability','FaceColor','green','DisplayName','low LL'); title ('Phase + Amplitude'); hh(1).BinWidth=6; %1/25 of xlim, as on the left hand side
xlim([0 150]);
text(max(xlim)*0.3, max(ylim)*0.8,'low LL') %legend

subplot(3,2,4); hold on; hh(2)=histogram (w2,'Normalization','Probability','FaceColor','blue','DisplayName','medium LL'); hh(2).BinWidth=6;
xlim([0 150]);
text(max(xlim)*0.3, max(ylim)*0.8,'medium LL') %legend

subplot(3,2,6); hold on; hh(3)=histogram (w3,'Normalization','Probability','FaceColor','magenta','DisplayName','high LL'); hh(3).BinWidth=6;
text(max(xlim)*0.4, max(ylim)*0.8,'high LL') %legend

xlim([0 160]);
xticks(0:50:150);


for i=1:3
    hh(i).FaceAlpha=0.2;
end

xx=xlabel('Autocorrelation time (d)');


%% fig design

figure(1); suptitle ('Loss of synchrony');
han=axes(figure(1),'visible','off'); 
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Probability'); 

han.YLabel.Position(1)= han.YLabel.Position(1)*1.6;

%% Saving 
cd([selpath,'/figures/fig1']);
fname='fig1F'; 
fig_save_font_22;

%% computing D, phase diffusion coefficients
D1=mean(rmoutliers(wt_l1(:,3)),'omitnan');
D1_std=std(rmoutliers(wt_l1(:,3)),'omitnan');

D2=mean(rmoutliers(wt_l2(:,3)),'omitnan');
D2_std=std(rmoutliers(wt_l2(:,3)),'omitnan');

D3=mean(rmoutliers(wt_l3(:,3)),'omitnan');
D3_std=std(rmoutliers(wt_l3(:,3)),'omitnan');



