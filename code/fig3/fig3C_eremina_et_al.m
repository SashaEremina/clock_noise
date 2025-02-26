close all;
clearvars -except selpath;

%% 
cd([selpath, '/simulations/traces_Fig3']);

%LL low
D=dir('*LLtrace.low*');
dd=readmatrix(D(1).name);
Ti=NaN(length(dd),length(D)); %time vectors
Tr=NaN(length(dd),length(D)); %traces

for i=1:length(D)
    dd=readmatrix(D(i).name);
    Ti(:,i)=dd(:,1);
    Tr(:,i)=dd(:,2);
end

%background shading
hold on; subplot(2,1,2);
yl=[0 max(dd(:,2)*10)];
patch_universal(dd(:,1),'night',dd(:,2),1,yl);

hold on; plot(Ti, Tr,'Color',[0.2 0.5 0.9 0.5]);
t(3)=plot(Ti(:,1),Tr(:,1),'Color',[0.2 0.5 0.9 0.5],'LineWidth',2,'DisplayName','low LL');

xlabel('Time (h)');
xlim([-12 120])
xticks(0:12:120)
ylim([0 0.4]);
yticks(0:0.1:0.4);

%LL medium
D=dir('*LLtrace.medium*');
dd=readmatrix(D(1).name);
Ti=NaN(length(dd),length(D)); 
Tr=NaN(length(dd),length(D)); 

for i=1:length(D)
    dd=readmatrix(D(i).name);
    Ti(:,i)=dd(:,1);
    Tr(:,i)=dd(:,2); 
end

%background shading
hold on; plot(Ti, Tr,'Color',[0.45 0.9 0.15 0.5]);
t(4)=plot(Ti(:,1),Tr(:,1),'Color',[0.45 0.9 0.15 0.5],'LineWidth',2,'DisplayName','medium LL');


%mock for legend
t(3)=plot(NaN,NaN,'Color',[0.2 0.5 0.9 0.5],'LineWidth',4,'DisplayName','low LL');
t(4)=plot(NaN,NaN,'Color',[0.45 0.9 0.15 0.5],'LineWidth',4,'DisplayName','medium LL');

legend ([t(3) t(4)],'NumColumns',2)
ylabel({'KaiC-P', 'level (normalised)'})
title ('Simulations under LL');

%% Saving - disabled
cd([selpath,'/figures/fig3']);
fname='fig3C';
fig_save_font_20_ssf;
