close all
clear all

%Load the data - fix
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\datasets'])
load('Bacillus_52_11-tracks2.mat');

overlay_t_and_y(s);
overlay_t_and_y_w_trace(s);

%% Saving (diabled) - choose an appropriate location
%cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
%fname='fig1B';
%set (gcf, 'InvertHardCopy','off'); %othersiwe the outline turns into black upon saving
%print(fname, '-dpng', '-r300', '-painters');