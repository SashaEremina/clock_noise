%establish a path:
selpath=uigetdir; %please, specify the location where all the code is saved

%make a directory for saving all figures
cd(selpath)
if ~isfolder('figures')
    mkdir figures
end

%make a directory for saving fig1 subfigures
cd([selpath,'/figures'])
if ~isfolder('fig1')
    mkdir fig1
end

%% Fig.1A-B - Growth channel kymograph
close all;
fig1B_eremina_et_al;
%for fig.1A will need to manually cut off first 4 timeframes from fig.1B

%% Fig.1C-D - Cell length and reporter fluorescence dynamics
close all;
fig1C_D_eremina_et_al;

%% Fig.1E - Period distributions
close all;
fig1E_eremina_et_al;

%% Fig.1F - Histograms of phase diffusion time and autocorrelation time
close all;
fig1F_eremina_et_al;

%% Fig. 1G - Noise loops
close all;
fig1G_eremina_et_al;

%% Fig. 1F - Cell synch
close all;
fig1H_eremina_et_al;

%% Supplementary

%Fig.S1.3 - raw fluorescence for low LL and high LL
close all;
fig_s1_3_eremina_et_al;

%% Fig.S1.4 - methods for clock dynamics analysis
close all;
fig_s1_4A_eremina_et_al; %hilbert transform

close all;
fig_s1_4B_eremina_et_al; %phase diffusion

close all;
fig_s1_4C_eremina_et_al; %autocorrelation damping analysis

%% Fig.S1.5 - C.V. in GE under x3 LL conditions
close all;
fig_s1_5_eremina_et_al;

%% Fig.S1.6 - noise loops under low and high LL
close all;
fig_s1_6_eremina_et_al;
