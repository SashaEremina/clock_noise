close all; clear all

%% Pt 1 - plotting the environments
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\simulations\noiseaveraging_SupplFig\new']);

%Plotting the environments: Caribbean 1
c1_sm=readmatrix('caribbean1_smoothed.csv');
c1_sq=readmatrix('caribbean1_square.csv');

%cd(['D:\from_CSCS\microscope\Sasha\2022-02-17-cyano2-prime\subAuto\Data']);
%load('intensity_adjusted.mat'); %this is where the coefficient of 0.18
%comes from

cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\caribbean_1']);
int=readmatrix('10-Aug-2022_WT_light_intensity.csv');
int=int-min(int); %remove when adjusted

time_light2=readmatrix('25-Feb-2022_WT_time_light_adjusted.csv');

c1_sm(:,2)=c1_sm(:,2)*19.7; %19.7 comes from the microscope measurements (Metamoph units -> real light)
c1_sq(:,2)=c1_sq(:,2)*19.7;
c1_r=int*19.7/0.18; %remove this after adjusted light intensity is uploaded

figure(1); subplot(2,1,1); title('Caribbean 1');

hold on; h(1)=plot(time_light2, c1_r,'LineWidth',1.5,'DisplayName','natural');
hold on; h(2)=plot(c1_sm(:,1),c1_sm(:,2),'LineWidth',1.5,'DisplayName','smoothed');
hold on; h(3)=plot(c1_sq(:,1),c1_sq(:,2),'LineWidth',1.5,'DisplayName','square');

xlim([-12 120]); xticks(0:24:120);
ylim([0 90]); yticks(0:15:90);

%% Plotting the environments: Caribbean 2
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\simulations\noiseaveraging_SupplFig\new']);
c2_sm=readmatrix('caribbean2_smoothed.csv');
c2_sq=readmatrix('caribbean2_square.csv');

% cd(['D:\from_CSCS\microscope\Sasha\2022-03-16-cyano2-prime\subAuto\Data']);
% load('intensity_adjusted.mat');
% load('time_light2.mat');

cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets\caribbean_2']);
int=readmatrix('07-Oct-2022_WT-reporter_light_intensity.csv');
time_light=readmatrix('07-Oct-2022_WT-reporter_time_light_adjusted.csv');

c2_sm(:,2)=c2_sm(:,2)*19.7; %19.7 comes from the microscope measurements (Metamoph units -> real light)
c2_sq(:,2)=c2_sq(:,2)*19.7;
c2_r=int*19.7;

box off;

figure(1); subplot(2,1,2); title('Caribbean 2');
hold on; h(1)=plot(time_light2(1:598),c2_r(1:598),'LineWidth',1.5,'DisplayName','natural');
hold on; h(2)=plot(c2_sm(1:598,1),c2_sm(1:598,2),'LineWidth',1.5,'DisplayName','smooth');
hold on; h(3)=plot(c2_sq(1:598,1),c2_sq(1:598,2),'LineWidth',1.5,'DisplayName','square');

legend ([h(3) h(2) h(1)]);

xlim([-12 120]); xticks(0:24:120);
ylim([0 90]); yticks(0:15:90);

%% Figure styling
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';

ylabel(han,'Light intensity ($\mu$mol $m^{-2}$ $s^{-1}$)');
xlabel(han,'Time (h)');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%Saving - disabled
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig6']);
fname='fig6C';
fig_save_font_20_box_off; %check for box/ no box!

