%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig1 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig3')
    mkdir fig3
end

%%

%Fig.3A - data with representative lineages
fig3A_eremina_et_al;

%Fig.3B - ACFs
fig3B_eremina_et_al; %ACFs too short again...

%Fig.3C - model output under LL
fig3C_eremina_et_al;

%Fig.3D - c.v. vs period plots (simulations and data)
fig3D_eremina_et_al;

%% Supplementary:
%Fig.s3_1 - antibiotic resistance
fig_s3_1_eremina_et_al;

%Fig.s3_2 - all traces for all KaiC mutants
fig_s3_2_eremina_et_al; %SP16(2) not in use? - resolve the confusion

%Fig.s3_3 - ACFs per period in period mutants
fig_s3_3_eremina_et_al; %ACFs too short again

%Fig.s3_4  - Kai mutants robustness
fig_s3_4_eremina_et_al; %(1) or (2) for Kaic-r215c high LL? why are there x2 in the first place?

%Fig.s3_5 - Posterior distributions
fig_s3_5_eremina_et_al;

%Fig.s3_6 - Simulations of different perturbations;
fig_s3_6_eremina_et_al;

%Fig.s3_7 - Light makes no difference to mut clock behaviour
fig_s3_7_eremina_et_al;

