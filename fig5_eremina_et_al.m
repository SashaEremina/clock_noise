%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig1 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig5')
    mkdir fig5
end

%%
% Fig.5A - clock reporter expression data under noisy day start/ end
fig5A_eremina_et_al;

%Fig.5B - clock buffers noise in the environment
fig5B_eremina_et_al; %check for the x-axis shift

%% Supplementary

%Fig.s5_1A - light conditions under noisy day start/ end
fig_s5_1A_eremina_et_al;

%Fig.s5_1B - fluorescence reporter data under noisy day start/ end
fig_s5_1B_eremina_et_al;

%Fig.s5_2 - clock noise is stable across the environments
fig_s5_2_eremina_et_al;
