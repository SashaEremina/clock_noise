%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig6 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig6')
    mkdir fig6
end

%% 

%Fig.6A - Raw data under Caribbean light
fig6A_eremina_et_al;

%Fig.6B - MTT under Caribbean
fig6B_eremina_et_al;

%Fig.6C - light intensity simulations
fig6C_eremina_et_al;

%Fig.6D - MTT under Caribbean simulations
fig6D_eremina_et_al;

%% Supplementary
%Fig_s21
fig_s21A_eremina_et_al; %Caribbean light intensities
fig_s21B_eremina_et_al; %Raw data under Caribbean light - all

%Fig_s22
fig_s22A_eremina_et_al; %noisy day raw data
fig_s22B_eremina_et_al; %MTT for data and simulations under different light environments
