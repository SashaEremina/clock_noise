close all; 
clearvars -except selpath;

%%
cd([selpath, '/data/acfs']);
t=readmatrix('acf_time_WT [LL].csv');
acf=readmatrix('acf_WT [LL].csv');
acf20=acf(46,1:245);
acf20=acf20(:,19:227); %to match the size of the time vector

figure;
h(1)=plot(t,acf20,'b','DisplayName','Fit');
hold on;
h(2)=plot(t,acf20,'b*','DisplayName','Data');

xl=find(t==-0.8);

autocor=acf20(xl:end);
time=t(xl:end);

[pks,locs] = findpeaks(autocor);
n_peaks=numel(pks);  
hold on
plot(time(locs),pks,'b.');

idx = pks <= 0;
locs(idx) = [];
pks(idx) = [];
plot(time(locs),pks,'ro');

p = polyfit(locs,log(pks),1);
curve_fit = exp(polyval(p,time));
h(3)=plot(time,curve_fit,'--g','LineWidth',2,'DisplayName','Damping curve');

xlim([-100 100]);
xticks(-120:24:120);
ylim([-1.5 1.5])

xlabel('Lag (h)');
ylabel('Autocorrelation');

legend(h([2 1 3]),'Location','bestoutside');
title('Signal autocorrelation');

text(28,1.15,'$y=a*e^{bx}$');

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig_s1_4C';
fig_save_font_20;
