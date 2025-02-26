close all; 
clearvars -except selpath


%% Load the data

cd([selpath, '/data/datasets/wt_med_LL_rep1']);

len=readmatrix('WT_reporter_mother_length.csv');
MY=readmatrix('WT_reporter_mother_mean_fluor.csv');
time_adjusted1=readmatrix('WT_reporter_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:1000
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

%% Fig.1C
fig1C_eremina_et_al;

%Saving
cd([selpath,'/figures/fig1'])
fname='fig1C';
%fig_save_font_22;
fig_save_font_22_ssf;

%% Fig.1D
close all
fig1D_eremina_et_al; 

%Saving
cd([selpath,'/figures/fig1'])
fname='fig1D';
%fig_save_font_22;
fig_save_font_22_ssf;