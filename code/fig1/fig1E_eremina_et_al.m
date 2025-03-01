clearvars -except selpath
close all;

%% data upload
cd([selpath, '/data/robustness']);

wt_l1=readmatrix('robustness_WT [low LL].csv'); %low LL
wt_l2=readmatrix('robustness_WT [LL].csv');%medium LL
wt_l3=readmatrix('robustness_WT [high LL].csv');%high LL



%data structures
w1=wt_l1(:,1); 
while min(w1)<2
    w1(w1==min(w1))=[]; %outlier filter
end
w2=wt_l2(:,1); 
w3=wt_l3(:,1);

w_all=NaN(2,length(w1)+length(w2)+length(w3));
w_all(1,1:length(w1))=w1;
w_all(1,length(w1)+1:length(w1)+length(w2))=w2;
w_all(1,length(w1)+length(w2)+1:end)=w3;

w_all(2,1:length(w1))=1;
w_all(2,length(w1)+1:length(w1)+length(w2))=2;
w_all(2,length(w1)+length(w2)+1:end)=3;

clear hh
figure(1);
hold on; hh(1)=histogram(w1,15,'Normalization','Probability','FaceColor','green','DisplayName','low LL');
hold on; hh(2)=histogram (w3,15,'Normalization','Probability','FaceColor','magenta','DisplayName','high LL');
hold on; hh(3)=histogram (w2,15,'Normalization','Probability','FaceColor','blue','DisplayName','medium LL');

legend (hh([1 3 2 ]))

for i=1:3
    hh(i).FaceAlpha=0.3;
    hh(i).BinWidth=0.2;
end

xlabel('Period (h)');
ylabel ('Probability')

v1=vline(mean(w1,'omitnan'),'--g');
v2=vline(mean(w2,'omitnan'),'--b');
v3=vline(mean(w3,'omitnan'),'--m');

v1.LineWidth=2; v1.DisplayName='low LL mean';
v2.LineWidth=2; v2.DisplayName='medium LL mean';
v3.LineWidth=2; v3.DisplayName='high LL mean';

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig1E';
%fig_save_font_22
fig_save_font_22_ssf;

