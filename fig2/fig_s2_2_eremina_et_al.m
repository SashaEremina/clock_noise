close all;
clear all;

%load the data
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\robustness']);
prkE=readmatrix('robustness_ΔprkE [LL].csv');
prkE(19,:)=[]; %removing the sick cell;

pex=readmatrix('robustness_Δpex [LL].csv');
ldpA=readmatrix('robustness_ΔldpA [LL].csv');
lalA=readmatrix('robustness_ΔlalA [LL].csv');
WT=readmatrix('robustness_WT (ΔlalA) [LL].csv');


%establishing a color palette
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];
cp=cp./255;


%% Part 1, autocorrelation time: removing the outliers
w1=(2./[ldpA(:,2)'])/24; %del_ldpA
w1=rmoutliers(w1,'percentiles',[0 98]);

w2=(2./[pex(:,2)'])/24; %del_pex#
w2=rmoutliers(w2,'percentiles',[0 92]);

w3=(2./[prkE(:,2)'])/24; %del_prkE

w4=(2./[lalA(:,2)'])/24; %del_lalA
w4=rmoutliers(w4,'percentiles',[0 99]);
w4(w4>1000)=NaN; %only for plotting purposes

w5=(2./[WT(:,2)'])/24;
w5=rmoutliers(w5,'percentiles',[0 86]);
w5(w5>1000)=NaN; %only for plotting purposes


%% Plotting
figure(1);

% Figure structure
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
titles = {'WT','$\Delta$\it ldpA', '$\Delta$\it pex', '$\Delta$\it prkE','$\Delta$\it lalA'};  
% Set annotation for each row of subplots
titleHandles = gobjects(numel(titles),1); 

%Actual plotting
subplot(5,2,2); h(5)=histogram(w5,'Normalization', 'probability'); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.25:0.5); ylim ([0 0.4]); text(0.6,0.6,'WT','Units','normalized') %legend ('WT') 
subplot(5,2,4); h(1)=histogram(w1,'Normalization', 'probability'); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.25:0.5); ylim ([0 0.4]); text(0.6,0.6,'$\Delta$\it ldpA','Units','normalized'); %legend ('$\Delta$ldpA')
subplot(5,2,6); h(2)=histogram(w2,'Normalization', 'probability'); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.25:0.5); ylim ([0 0.4]); text(0.6,0.6,'$\Delta$\it pex','Units','normalized'); %legend ('$\Delta$pex')
subplot(5,2,8); h(3)=histogram(w3,'Normalization', 'probability'); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.25:0.5); ylim ([0 0.4]); text(0.6,0.6,'$\Delta$\it prkE','Units','normalized'); %legend ('$\Delta$prkE')
subplot(5,2,10); h(4)=histogram(w4,'Normalization', 'probability'); hold on; xticks(0:50:200); xlim([0 200]); yticks(0:0.25:0.5); ylim ([0 0.4]); text(0.6,0.6,'$\Delta$\it lalA','Units','normalized'); %legend ('$\Delta$lalA')
xlabel('Autocorrelation time (d)');

for hh=1:5
    h(hh).BinWidth=10;
    if hh==5
         h(hh).FaceColor=cp(1,:);
    else     
    h(hh).FaceColor=cp(hh+1,:);
    end
    h(hh).EdgeColor=h(hh).FaceColor;
end

%% Part 2, phase diffusion time: removing the outliers
w1=(1./[ldpA(:,3)'])/24; %del_ldpA
w1(w1==max(w1))=[];

w2=(1./[pex(:,3)'])/24; %del_pex
w2(w2==max(w2))=[];

w3=(1./[prkE(:,3)'])/24; %del_prkE

w4=(1./[lalA(:,3)'])/24; %del_lalA

w5=(1./[WT(:,3)'])/24; %WT
w5(w5==max(w5))=[];


%% Plotting

figure(1); hold on; 
subplot(5,2,1); h(5)=histogram(w5,'Normalization', 'probability'); hold on; yticks(0:0.2:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.3])
subplot(5,2,3); h(1)=histogram(w1,'Normalization', 'probability'); hold on; yticks(0:0.2:0.2); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.3])
subplot(5,2,5); h(2)=histogram(w2,'Normalization', 'probability'); hold on; yticks(0:0.2:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.3])
subplot(5,2,7); h(3)=histogram(w3,'Normalization', 'probability'); hold on; yticks(0:0.2:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.3])
subplot(5,2,9); h(4)=histogram(w4,'Normalization', 'probability'); hold on; yticks(0:0.2:0.5); xticks(0:750:2250); xlim([0 2250]); ylim ([0 0.3])

for hh=1:5
    h(hh).BinWidth=150;
    if hh==5
         h(hh).FaceColor=cp(1,:);
    else     
    h(hh).FaceColor=cp(hh+1,:);
    end
    h(hh).EdgeColor=h(hh).FaceColor;
end
xlabel('Phase diffusion time (d)');

figure(1)
han=axes(figure(1),'visible','off'); 
han.YLabel.Visible='on';
ylabel(han,'Probability'); 
han.YLabel.Position(1)=han.YLabel.Position(1)*1.4;

%% Saving - disabled
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig2']);
fname='fig_s2_2';
fig_save_font_20;