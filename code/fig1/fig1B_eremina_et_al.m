close all
clearvars -except selpath

%Load the data

cd([selpath,'/data/datasets'])
load('Bacillus_52_11-tracks2.mat');

overlay_t_and_y(s);
overlay_t_and_y_w_trace(s);

%% Saving
cd([selpath,'/figures/fig1'])
fname='fig1B';
set (gcf, 'InvertHardCopy','off'); %othersiwe the outline turns into black upon saving
print(fname, '-dpng', '-r300', '-vector');