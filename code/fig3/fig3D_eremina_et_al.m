close all;
clearvars -except selpath;

%% 
cd([selpath, '/simulations/posterior-Fig3/trajectories']);
DD=dir('sensitivity3*');

dd2=readmatrix(DD(1).name);
Tp2=NaN(length(dd2),length(DD)); %time vectors
Tcv2=NaN(length(dd2),length(DD)); %traces

for i=1:length(DD)
    dd2=readmatrix(DD(i).name);
    Tp2(1:length(dd2),i)=dd2(:,1);
    Tcv2(1:length(dd2),i)=dd2(:,2);
end


g=[.4 .4 .4];
figure;
p(2)=plot(NaN,NaN,'LineWidth',3,'Color',g,'DisplayName','model');


%% error bars

cd([selpath, '/data/p2pstats_errorbars']);

WT_ml=readmatrix('p2pstats_bootstrap_WT [LL].csv');
WT_ll=readmatrix('p2pstats_bootstrap_WT [low LL].csv');
WT_hl=readmatrix('p2pstats_bootstrap_WT [high LL].csv');

WT_ab=readmatrix('p2pstats_bootstrap_WT-Ab [LL].csv');

T495A=readmatrix('p2pstats_bootstrap_KaiC-T495A [high LL].csv');
R215C=readmatrix('p2pstats_bootstrap_KaiC-R215C (1) [high LL].csv');
R215C_m=readmatrix('p2pstats_bootstrap_KaiC-R215C [LL].csv');

SP16=readmatrix('p2pstats_bootstrap_KaiC-R393C [LL].csv'); 
LP48=readmatrix('p2pstats_bootstrap_KaiC-A251V [LL].csv');


% calculating noise
WT_m_cv=sqrt(WT_ml(2,3))/WT_ml(2,2);
WT_l_cv=sqrt(WT_ll(2,3))/WT_ll(2,2);
WT_h_cv=sqrt(WT_hl(2,3))/WT_hl(2,2);
WT_ab_cv=sqrt(WT_ab(2,3))/WT_ab(2,2);

LP48_cv=sqrt(LP48(2,3))/LP48(2,2);
T495A_cv=sqrt(T495A(2,3))/T495A(2,2);
R215C_cv=sqrt(R215C(2,3))/R215C(2,2);
R215C_m_cv=sqrt(R215C_m(2,3))/R215C_m(2,2);
SP16_cv=sqrt(SP16(2,3))/SP16(2,2);

%% Plotting the data points
hold on;

%plot the best fit
hh=plot(Tp2(:,101),Tcv2(:,101),'Color',g, 'LineWidth',3,'DisplayName','model'); 

xlim([0 60]); xticks(0:12:60); xlabel('Period (h)');
ylim([0 0.4]); yticks(0:0.1:0.4); ylabel('C.V.');

%plot the data points
hold on; h(1)=errorbar(WT_ml(2,2), WT_m_cv, WT_m_cv-WT_ml(2,8), WT_ml(2,9)-WT_m_cv, WT_ml(2,2)-WT_ml(2,4), WT_ml(2,5)-WT_ml(2,2),...
    'bo','DisplayName','WT medium LL');

hold on; h(2)=errorbar(WT_hl(2,2), WT_h_cv, WT_h_cv-WT_hl(2,8), WT_hl(2,9)-WT_h_cv, WT_hl(2,2)-WT_hl(2,4), WT_hl(2,5)-WT_hl(2,2),...
   'bo','DisplayName','WT high LL');

hold on; h(3)=errorbar(WT_ll(2,2), WT_l_cv, WT_l_cv-WT_ll(2,8), WT_ll(2,9)-WT_l_cv, WT_ll(2,2)-WT_ll(2,4), WT_ll(2,5)-WT_ll(2,2),...
   'bo','DisplayName','WT low LL');

hold on; h(4)=errorbar(WT_ab(2,2), WT_ab_cv, WT_ab_cv-WT_ab(2,8), WT_ab(2,9)-WT_ab_cv, WT_ab(2,2)-WT_ab(2,4), WT_ab(2,5)-WT_ab(2,2),...
   'bo','DisplayName','WT-Ab medium LL');

%muts
hold on; h(5)=errorbar(LP48(2,2), LP48_cv, LP48_cv-LP48(2,8), LP48(2,9)-LP48_cv, LP48(2,2)-LP48(2,4), LP48(2,5)-LP48(2,2),...
   'bo','DisplayName','LP48 medium LL');

hold on; h(6)=errorbar(SP16(2,2), SP16_cv, SP16_cv-SP16(2,8), SP16(2,9)-SP16_cv, SP16(2,2)-SP16(2,4), SP16(2,5)-SP16(2,2),...
   'bo','DisplayName','SP16 medium LL');

hold on; h(7)=errorbar(R215C(2,2), R215C_cv, R215C_cv-R215C(2,8), R215C(2,9)-R215C_cv, R215C(2,2)-R215C(2,4), R215C(2,5)-R215C(2,2),...
   'bo','DisplayName','KaiC-R215C high LL');

hold on; h(8)=errorbar(R215C_m(2,2), R215C_m_cv, R215C_m_cv-R215C_m(2,8), R215C_m(2,9)-R215C_m_cv, R215C_m(2,2)-R215C_m(2,4), R215C_m(2,5)-R215C_m(2,2),...
   'bo','DisplayName','KaiC-R215C medium LL');

hold on; h(9)=errorbar(T495A(2,2), T495A_cv, T495A_cv-T495A(2,8), T495A(2,9)-T495A_cv, T495A(2,2)-T495A(2,4), T495A(2,5)-T495A(2,2),...
   'bo','DisplayName','KaiC-T495A high LL');


%styling
xlim([0 60]); xticks(0:12:60); xlabel('Period (h)');
ylim([0 0.4]); yticks(0:0.1:0.4); ylabel('C.V.');

%establishing the colot palette
cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

c=[254,235,226;
251,180,185;
247,104,161;
174,1,126];

c=c/255;


%wts
h(1).MarkerFaceColor=[0, 0.9, 0.9];
h(2).MarkerFaceColor= [1 0 1]; 
h(3).MarkerFaceColor=[0.4660, 0.6740, 0.1880];
h(4).MarkerFaceColor= [0.6350, 0.0780, 0.1840];

%muts
h(5).MarkerFaceColor= c(4,:);  
h(6).MarkerFaceColor= c(3,:);
h(7).MarkerFaceColor= cc(2,:);
h(8).MarkerFaceColor= cc(3,:);
h(9).MarkerFaceColor=cc(4,:);


for pp=1:9
    h(pp).MarkerEdgeColor=h(pp).MarkerFaceColor;
    h(pp).Color=h(pp).MarkerEdgeColor;
    h(pp).LineWidth=2;
end

legend ([hh,h(3),h(1:2),h(4),h(7:9),h(5:6)],'Location','BestOutside')

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig3D';
fig_save_font_20;
