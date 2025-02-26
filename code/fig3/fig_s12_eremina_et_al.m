close all;
clearvars -except selpath;

%%
cd([selpath, '/data/meanautocovariance']);

A_SP16 = readmatrix('autocov_KaiC-R393C [LL].csv');
A_LP48= readmatrix('autocov_KaiC-A251V [LL].csv');

%color scheme
c=[254,235,226;
251,180,185;
247,104,161;
174,1,126];

c=c/255;

cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

%autocov->ACF
A_SP16(:,2)=A_SP16(:,2)./max(A_SP16(:,2));
A_LP48(:,2)=A_LP48(:,2)./max(A_LP48(:,2));


figure; %plotting average
p2=plot(A_SP16(:,1),A_SP16(:,2),'DisplayName','SP16 medium LL'); hold on
p3=plot(A_LP48(:,1),A_LP48(:,2),'k','DisplayName','LP48 medium LL'); hold on

p2.LineWidth=3; p2.Color=cc(4,:); p2.Color(4)=0.6;
p3.LineWidth=3; p3.Color=c(4,:);

l=legend([p3 p2],'NumColumns',2);

xlim([-102 102]); 
xticks(-96:24:96);
ylim([-1.5 1.5]);

xlabel('Lag (h)')
ylabel('Autocorrelation')

box off

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s12';
fig_save_font_20_ssf;