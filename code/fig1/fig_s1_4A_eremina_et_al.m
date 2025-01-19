close all;
clearvars -except selpath;

%% load the data
cd([selpath, '/data/datasets/wt_med_LL_rep1']);
MY=readmatrix('WT_reporter_mother_mean_fluor.csv');
time_adjusted=readmatrix('WT_reporter_time_adjusted.csv');

%%Colorblind palette download
cd([selpath, '/code/helper functions']);
load('colorblind_colormap.mat');
ii=4;

%data smoothing for visualisation
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)  
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i),5); %coefficient changed for visualisation purposes
end

%hilbert transform
MY_t=MY_smooth(:,10);
t=time_adjusted(1:189)';
MY_t=MY_t(1:189);
MY_tn=normalize(MY_t);
yh=hilbert(MY_tn);

%%Fitting fluorescence data
SineParams=sineFit(t(3:end),MY_tn(3:end),0);
x=t(3:end);
xstart=x(1);
xend=x(end);
xLength=xend-xstart;
xSstep=min(xLength/100,1/SineParams(3)*0.1);
xS=xstart:xSstep:xend;
y5=SineParams(1)+SineParams(2)*sin(2*pi*SineParams(3)*xS+SineParams(4));

%% Plotting
f(1)=plot(xS, y5,'--','DisplayName','Sine fit','LineWidth',1,'Color',colorblind(ii,:)); ii=ii+1;

inst_phase = angle(yh);
inst_phase_n=normalize(inst_phase,'range');
hold on; f(2)=plot(t,inst_phase_n,'DisplayName','phase ({\it $\phi$(t)})','LineWidth',1,'Color',colorblind(ii,:)); ii=ii+1;

inst_amplitude = abs(yh);
hold on; f(3)=plot(t,inst_amplitude,'DisplayName','amplitude ({\it a(t)})','LineWidth',1,'Color',colorblind(ii,:)); ii=ii+1;

hold on; f(4)=plot(t,MY_tn,'DisplayName','fluorescence ({\it x(t)})','LineWidth',1,'Color',colorblind(ii,:)); ii=ii+1;

%%Titles, legends, axis
l=legend(f([2 3 4 1]),'Location','bestoutside'); 
xticks(0:24:140);
xlim([0 138]);
xlabel('Time (h)');

title ({'HT-based decomposition', 'of fluorescence signal'});
set(l,'box','off');

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig_s1_4A';
fig_save_font_20;