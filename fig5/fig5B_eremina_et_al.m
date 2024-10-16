close all;
clearvars -except selpath;

%% noisy day start/end simulation
cd([selpath, '/simulations/p2pStatistics/noisyenvironments_Fig6']);

nde_sim=readmatrix('LDsim_nde.csv'); 
nds_sim=readmatrix('LDsim_nds.csv');

nde_exp=readmatrix('LDexp_nde.csv');
nds_exp=readmatrix('LDexp_nds.csv');

%% Noisy day end - plotting
figure;
hold on;
subplot(2,1,2); 
p(1)=errorbar(nde_sim(:,1)+0.05,nde_sim(:,2),nde_sim(:,2).*nde_sim(:,3),'ob','LineWidth',1); hold on;
dd(1)=errorbar(nde_exp(:,1)-0.05,nde_exp(:,2),nde_exp(:,2).*nde_exp(:,3),'om','LineWidth',1); hold on;

xlabel('Previous day length (h)');
xlim([10 15]); ylim([4 10]); xticks(10:15); yticks(5:1:9); ylim([5 9])
title('Noisy day end');

%fit plot
tts_a=nde_exp(:,2)';
d=nde_exp(:,1)';

[P,S]=polyfit(d,tts_a,1);
yfit=polyval(P,d);

%GOF estimate
[~,delta]=polyval(P,d,S);

f = polyval(P,d);
T = table(d,tts_a,f,tts_a-f,'VariableNames',{'X','Y','Fit','FitError'});
round([T.FitError],2);

hold on;
h(2)=plot(d,yfit,'r-','DisplayName',strcat('Data fit $\ $  $\ $ '));

%GOF plot
[y_fit2,i]=sort(yfit);
delta2=delta(i);
d2=d(i);

h(3)=plot(d2,y_fit2+2*delta2,'k--','DisplayName','95\% CI');
h(4)=plot(d2,y_fit2-2*delta2,'k--');

text(11.5, 8.5, strcat('slope=',num2str(round(P(1),2))));
text(12.25, 7.9,'$\downarrow$');


p(1).DisplayName='Simulation';
dd(1).DisplayName='Experiment';


%% Noisy day start - plotting

hold on;
subplot(2,1,1); 
p(2)=errorbar(nds_sim(:,1)+0.05,nds_sim(:,2),nds_sim(:,2).*nds_sim(:,3),'ob','LineWidth',1); hold on;
dd(2)=errorbar(nds_exp(:,1)-0.05,nds_exp(:,2),nds_exp(:,2).*nds_exp(:,3),'om','LineWidth',1); hold on;


xlabel('Dawn delay (h)');
xlim([-1 4]); xticks(0:4); yticks(5:1:10);
title('Noisy day start');

for pp=1:2
    p(pp).MarkerSize=4; p(pp).MarkerFaceColor=p(pp).MarkerEdgeColor;
    dd(pp).MarkerSize=4; dd(pp).MarkerFaceColor=dd(pp).MarkerEdgeColor;
end


tts_a=nds_exp(:,2)';
d=nds_exp(:,1)';

[P,S]=polyfit(d,tts_a,1);
yfit=polyval(P,d);

%GOF estimate
[y_fit,delta]=polyval(P,d,S);
f = polyval(P,d);

T = table(d,tts_a,f,tts_a-f,'VariableNames',{'X','Y','Fit','FitError'});
round([T.FitError],2);

hold on;
h(2)=plot(d,yfit,'r-','DisplayName',strcat('Data fit'));

hold on;
text(0.2, 9, strcat('slope=',num2str(round(P(1),2))));
text(0.9,8, '$\downarrow$');


%GOF plot
[y_fit2,i]=sort(yfit);
delta2=delta(i);
d2=d(i);

h(3)=plot(d2,y_fit2+2*delta2,'k--','DisplayName','95\% CI');
h(4)=plot(d2,y_fit2-2*delta2,'k--');

p(2).DisplayName='Simulation';
dd(2).DisplayName='Experiment';

legend([p(2) dd(2) h(2:3)],'NumColumns',2,'Location','SouthEast')

%% Figure styling
ax = axes(figure (1));
han = gca;
han.Visible = 'off';

ylabel('Mean trough time (h)')
han.YLabel.Visible = 'on';

%% Saving
cd([selpath,'/figures/fig5']);
fname='fig5B';
fig_save_font_20_box_on;
