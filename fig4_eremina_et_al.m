%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig4 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig4')
    mkdir fig4
end

%%
%Fig.4A - clock reporter expression data and model output
fig4A_eremina_et_al;

%Fig.4B - phase variance under LL and LD
fig4B_eremina_et_al;

%% Supplementary:

%Fig.s4_1 - all traces for LD conditions
fig_s4_1_eremina_et_al;

%Fig.s4_2 - trough-to-trough variance in different genetic backgrounds
fig_s4_2_eremina_et_al;