
close all;
clearvars -except selpath;

%establishing a color palette
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];
cp=cp./255;


%% loading the data 
cd([selpath, '/data/meanautocovariance']);

prkE = readmatrix('autocov_ΔprkE [LL].csv'); 
pex= readmatrix('autocov_Δpex [LL].csv');
ldpA=readmatrix('autocov_ΔldpA [LL].csv');
lalA=readmatrix('autocov_ΔlalA [LL].csv');
WT=readmatrix('autocov_WT (ΔlalA) [LL].csv');

%autocovariance -> acf;
WT(:,2)= WT(:,2)./max(WT(:,2));
prkE(:,2)=prkE(:,2)./max(prkE(:,2));
pex(:,2)=pex(:,2)./max(pex(:,2));
ldpA(:,2)=ldpA(:,2)./max(ldpA(:,2));
lalA(:,2)=lalA(:,2)./max(lalA(:,2));

figure; hold on;
subplot(2,1,1)


p1=plot(WT(:,1),WT(:,2),'m--','DisplayName','WT'); hold on
p2=plot(ldpA(:,1),ldpA(:,2),'b--','DisplayName','\it\DeltaldpA'); hold on
p3=plot(pex(:,1),pex(:,2),'g--','DisplayName','\it\Deltapex '); hold on

%p1=plot(WT(:,1),WT(:,2),'m--','DisplayName','WT $\ $  $\ $ $\ $ $\ $  $\ $ $\ $  '); hold on
%p2=plot(ldpA(:,1),ldpA(:,2),'b--','DisplayName','$\Delta$\it ldpA '); hold on
%p3=plot(pex(:,1),pex(:,2),'g--','DisplayName','$\Delta$\it pex '); hold on

p1.Color=cp(1,:);
p2.Color=cp(2,:);
p3.Color=cp(3,:);

l=legend([p1 p2 p3],'Location','NorthEastoutside');

xlim([-100 100]); xticks(-96:24:96); xtickangle(45)
ylim([-1.2 1.2]);


subplot(2,1,2);

p4=plot(prkE(:,1),prkE(:,2),'y--','DisplayName','\it\DeltaprkE'); hold on
p5=plot(lalA(:,1),lalA(:,2),'r--','DisplayName','\it\DeltalalA'); hold on
p6=plot(WT(:,1),WT(:,2),'m--','DisplayName','WT');

%p4=plot(prkE(:,1),prkE(:,2),'y--','DisplayName','$\Delta$\it prkE '); hold on
%p5=plot(lalA(:,1),lalA(:,2),'r--','DisplayName','$\Delta$\it lalA '); hold on
%p6=plot(WT(:,1),WT(:,2),'m--','DisplayName','WT $\ $  $\ $ $\ $ $\ $  $\ $ $\ $  ');

p4.Color=cp(4,:);
p5.Color=cp(5,:);
p6.Color=cp(1,:);

xlabel ('Lag (h)');

p1.LineWidth=3; p1.Color(4)=0.5;
p2.LineWidth=3; p2.Color(4)=0.5;
p3.LineWidth=3; p3.Color(4)=0.5;
p4.LineWidth=3; p4.Color(4)=0.5;
p5.LineWidth=3; p5.Color(4)=0.5;
p6.LineWidth=3; p6.Color(4)=0.5;


l=legend([p6 p4 p5],'Location','NorthEastoutside');

xlim([-100 100]); xticks(-96:24:96); xtickangle(45)
ylim([-1.2 1.2]);

%% Figure styling
figure(1); hold on;
han=axes(figure(1),'visible','off');
han.YLabel.Visible='on';
ylabel(han,'Autocorrelation');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig2']);
fname='fig2C';
%fig_save_font_20;
fig_save_font_20_ssf;


