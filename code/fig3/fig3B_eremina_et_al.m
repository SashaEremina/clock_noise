close all;
clearvars -except selpath;

cd([selpath, '/data/meanautocovariance']);

%% Top panel
A_R215C = readmatrix('autocov_KaiC-R215C (1) [high LL].csv');
A_T495A= readmatrix('autocov_KaiC-T495A [high LL].csv');
WTh=readmatrix('autocov_WT [high LL].csv');

%color scheme
cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

%autocovariance -> ACF
WTh(:,2)=WTh(:,2)./ max(WTh(:,2));
A_R215C(:,2)=A_R215C(:,2)./ max(A_R215C(:,2));
A_T495A(:,2)=A_T495A(:,2)./ max(A_T495A(:,2));

figure;
subplot(2,1,1)
p1=plot(WTh(:,1),WTh(:,2),'m','DisplayName','WT high LL'); hold on
p2=plot(A_R215C(:,1),A_R215C(:,2),'b','DisplayName','KaiC-R215C high LL'); hold on
p3=plot(A_T495A(:,1),A_T495A(:,2),'k','DisplayName','KaiC-T495A high LL'); hold on

p1.LineWidth=3;
p2.LineWidth=3; p2.Color=cc(2,:);
p3.LineWidth=3; p3.Color=cc(3,:);
l=legend([p1 p2 p3],'Location','NorthEastoutside');

xlim([-102 102]); xticks(-96:24:96); xtickangle(45);
ylim([-1.2 1.2]);

xlabel('Lag (h)')

%% Bottom panel
clearvars -except selpath;

cd([selpath, '/data/meanautocovariance']);

%color scheme
c=[254,235,226;
251,180,185;
247,104,161;
174,1,126];

c=c/255;

A_SP16 = readmatrix('autocov_KaiC-R393C [LL].csv');
A_LP48= readmatrix('autocov_KaiC-A251V [LL].csv');

%autocov -> ACF
A_SP16(:,2)=A_SP16(:,2)./max(A_SP16(:,2));
A_LP48(:,2)=A_LP48(:,2)./max(A_LP48(:,2));


%Finding periods of an individual lineage
[pks1, locs1]=findpeaks(A_SP16(:,2));
st1=mean(diff(locs1))*0.75; %0.75 is an imaging frequency (45 min)

[pks2, locs2]=findpeaks(A_LP48(:,2));
st2=mean(diff(locs2))*0.75; 

st4=24; 

figure(1); hold on;
subplot(2,1,2); 
p2=plot(A_SP16(:,1)*st4/st1,A_SP16(:,2),'--','DisplayName','SP16 medium LL'); hold on; 
p3=plot(A_LP48(:,1)*st4/st2,A_LP48(:,2),'k--','DisplayName','LP48 medium LL ');

xticks(-96:24:96); xlim([-96 96]);
xticklabels({'4','3','2','1','0','1','2','3','4'});

xtickangle(45);

p2.LineWidth=3; p2.Color=c(2,:);
p3.LineWidth=3; p3.Color=c(4,:);

l=legend([p3 p2],'Location','NorthEastoutside');

xlabel ('Lag/period');


%% Figure styling
figure(1); hold on;
han=axes(figure(1),'visible','off');
han.YLabel.Visible='on';
ylabel(han,'Autocorrelation');

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig3B';
fig_save_font_20;
