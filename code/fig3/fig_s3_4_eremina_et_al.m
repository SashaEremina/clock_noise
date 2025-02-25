close all;
clearvars -except selpath;

%% 

%establishing the color palette
cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

c=[254,235,226;
251,180,185;
247,104,161;
174,1,126];

c=c/255;

%import the data
cd([selpath, '/data/robustness']);

WT2=readmatrix('robustness_WT [high LL].csv');
r215c=readmatrix('robustness_KaiC-R215C (1) [high LL].csv');
t495a=readmatrix('robustness_KaiC-T495A [high LL].csv');
r393c=readmatrix('robustness_KaiC-R393C [LL].csv');
a251v=readmatrix('robustness_KaiC-A251V [LL].csv');

%% Plotting
%Establishing the figure structure
figure(1)
subplotLayout = [5,2];
ax = gobjects(fliplr(subplotLayout));
for i = 1:prod(subplotLayout)
    ax(i) = subplot(subplotLayout(1),subplotLayout(2),i);
end
set(ax,'Units','Normalize') % this is typically the default
ax = ax'; % now axis handles are same shape as subplot layout
% Reduce vertical space of axes just a bit to make room for "titles"
axPos = cell2mat(get(ax, 'Position'));
axPos(:,4) = axPos(:,4).*.98; % reduces vert space to 96% of height
set(ax, {'Position'}, mat2cell(axPos, ones(numel(ax),1), 4))
% Get upper position of each row of axes, normalized coordinates
axPos = cell2mat(get(ax(:,1), 'Position'));
axUpperPos = sum(axPos(:,[2,4]),2);  %upper pos.
% Get center position for 1st row (assumes all rows have same center)
axPos = cell2mat(get(ax(1,[1,end]),'Position'));
axCenterPos = mean([axPos(1,1), sum(axPos(2,[1,3]))]);
% list all titles in order (top to bottom)
titles = {'WT2', 'SP16','KaiC-R215C','LP48','KaiC-T495A'};  
% Set annotation for each row of subplots
titleHandles = gobjects(numel(titles),1); 

%% Pt1 - Phase diffusion time
w2=(1./(WT2(:,3)'))/24; 
w3=(1./(a251v(:,3)'))/24; 
w4=(1./(r393c(:,3)'))/24; 
w5=(1./(r215c(:,3)'))/24;
w6=(1./(t495a(:,3)'))/24; 

subplot(5,2,1); h(2)=histogram(w2,'Normalization', 'probability','LineWidth',0.5); hold on; yticks(0:0.5:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.9]); text(0.35,0.6,'WT','Units','normalized');
subplot(5,2,7); h(3)=histogram(w4,'Normalization', 'probability','LineWidth',0.5); hold on; yticks(0:0.5:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.9]); text(0.35,0.6,'SP16','Units','normalized');
subplot(5,2,3); h(4)=histogram(w5,'Normalization', 'probability','LineWidth',0.5); hold on; yticks(0:0.5:0.5); xticks(0:75:225); xlim([0 225]); ylim ([0 0.9]); text(0.35,0.6,'KaiC-R215C','Units','normalized')
subplot(5,2,9); h(5)=histogram(w3,'Normalization', 'probability','LineWidth',0.5); hold on; yticks(0:0.5:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.9]); text(0.35,0.6,'LP48','Units','normalized');
xlabel('Phase diffusion time (d)'); hold on;
subplot(5,2,5); h(6)=histogram(w6,'Normalization', 'probability','LineWidth',0.5); hold on; yticks(0:0.5:0.5); xticks(0:75:225); xlim([0 225]); ylim ([0 0.9]); text(0.35,0.6,'KaiC-T495A','Units','normalized') ;

h(2).FaceColor= cc(1,:);
h(3).FaceColor= c(3,:);

h(4).FaceColor= cc(2,:);
h(5).FaceColor= c(4,:);

h(6).FaceColor= cc(3,:);

for hh=2:6
    h(hh).BinWidth=150;
    if hh==4 || hh==6
        h(hh).BinWidth=15;
    end    

     h(hh).EdgeColor=[0 0 0]; %h(hh).FaceColor;
end

%% Pt2 - Autocorrelation time

w2=(2./(WT2(:,2)'))/24; 
w2=rmoutliers(w2,'percentiles',[0 82]);

w3=(2./(a251v(:,2)'))/24; 
w3=rmoutliers(w3,'percentiles',[0 80]);

w4=(2./(r393c(:,2)'))/24; 
w4=rmoutliers(w4,'percentiles',[0 99]);

w5=(2./(r215c(:,2)'))/24;
w5=rmoutliers(w5,'percentiles',[0 86]);

w6=(2./(t495a(:,2)'))/24; 

subplot(5,2,2); h(2)=histogram(w2,'Normalization', 'probability','LineWidth',0.5); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.5:0.5); ylim ([0 0.96]); text(0.35,0.6,'high LL','Units','normalized') %legend ('WT') 
subplot(5,2,8); h(3)=histogram(w4,'Normalization', 'probability','LineWidth',0.5); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.5:0.5); ylim ([0 0.96]); text(0.35,0.6,'medium LL','Units','normalized') %legend ('WT') 
subplot(5,2,4); h(4)=histogram(w5,'Normalization', 'probability','LineWidth',0.5); hold on; xticks(0:50:200); xlim([0 100]); yticks(0:0.5:0.5); ylim ([0 0.96]); text(0.35,0.6,'high LL','Units','normalized') %legend ('WT') 
subplot(5,2,10); h(5)=histogram(w3,'Normalization', 'probability','LineWidth',0.5); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.5:0.5); ylim ([0 0.96]); text(0.35,0.6,'medium LL','Units','normalized') %legend ('WT') 

xlabel('Autocorrelation time (d)'); hold on;
subplot(5,2,6); h(6)=histogram(w6,'Normalization', 'probability','LineWidth',0.5); hold on; xticks(0:25:100); xlim([0 100]); yticks(0:0.5:0.5); ylim ([0 0.96]); text(0.35,0.6,'high LL','Units','normalized') %legend ('WT') 

h(2).FaceColor= cc(1,:);
h(3).FaceColor= c(3,:);

h(4).FaceColor= cc(2,:);
h(5).FaceColor= c(4,:);

h(6).FaceColor= cc(3,:);


for hh=2:6
    if hh ~=4 && hh ~=6
        h(hh).BinWidth=10;
    else
        h(hh).BinWidth=5;    
    end
    h(hh).EdgeColor=[0 0 0];%h(hh).FaceColor;
end

%% Figure styling

figure(1)
han=axes(figure(1),'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'Probability'); 
han.YLabel.Position(1)=han.YLabel.Position(1)*1.4;

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s3_4';
fig_save_font_18_ssf;
