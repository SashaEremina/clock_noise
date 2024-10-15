%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig1 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig2')
    mkdir fig2
end
%% Fig. 2

%Fig.2A - a schematic

%Fig.2B - Example lineages fluorescence
fig2B_eremina_et_al;

%Fig.2C - ACFs
fig2C_eremina_et_al;

%Fig.2D - mother synch + daughters phase diff.
fig2D_eremina_et_al;

%% Supplementary
%Fig.S2.1
fig_s2_1_eremina_et_al; %violin plots for del_reg periods

%Fig.S2.2 - phase diffusion time and autocorrelation time for del_regs
fig_s2_2_eremina_et_al;

%Fig.S2.3 - noise loops for del_regs
fig_s2_3_eremina_et_al;
