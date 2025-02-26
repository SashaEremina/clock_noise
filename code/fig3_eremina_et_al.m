%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig3 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig3')
    mkdir fig3
end

%%

%Fig.3A - data with representative lineages
fig3A_eremina_et_al;

%Fig.3B - ACFs
fig3B_eremina_et_al;

%Fig.3C - model output under LL
fig3C_eremina_et_al;

%Fig.3D - c.v. vs period plots (simulations and data)
fig3D_eremina_et_al;

%% Supplementary:
%Fig.s10 - antibiotic resistance
fig_s10_eremina_et_al;

%Fig.s11 - all traces for all KaiC mutants
fig_s11_eremina_et_al;

%Fig.s12 - ACFs per period in period mutants
fig_s12_eremina_et_al;

%Fig.s13 - Light makes no difference to mut clock behaviour
fig_s13_eremina_et_al;

%Fig.s14  - Kai mutants robustness
fig_s14_eremina_et_al;

%Fig.s15 - Posterior distributions
fig_s15_eremina_et_al;

%Fig.s16 - Simulations of different perturbations;
fig_s16_eremina_et_al;



