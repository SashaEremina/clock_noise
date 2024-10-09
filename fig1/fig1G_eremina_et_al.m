close all; clear all;

%% load the data - WT under medium LL
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\noiseloops']);

nwt2=readmatrix('noiseloop_phasealigned_WT (ΔKaiBC) [LL].csv');
nwt2_m=readmatrix('noiseloop_phasealigned2_WT (ΔKaiBC) [LL].csv');


%% Plotting
close all
figure; s(2)=subplot(2,1,2);

c=winter(64); %color map

for i=1:5
    if i<5
        p(i)=plot(nwt2_m(i*100:i*100+100,2),nwt2_m(i*100:i*100+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    else
        p(i)=plot(nwt2_m(i*100:570,2),nwt2_m(i*100:570,3),'LineWidth',2,'DisplayName',['period', '{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end

lgd=legend;
lgd.Location='bestoutside';

xlim([2*10^(-3) 10*10^(-3)])
xticks(2*10^(-3): 2.5*10^(-3): 10*10^(-3))

ylim([0 0.04]);
yticks(0:0.01:0.04)

ylabel('C.V.$^2$');
xlabel('1/[YFP]');
title('Average noise per period')

hold on; s(1)=subplot(2,1,1);
pp=plot(nwt2(:,2),nwt2(:,3),'-','LineWidth',2,'DisplayName','mean $\ $ $\ $');
pp.Color=c(14,:);
hold on;
pp2=plot(nwt2(:,2),nwt2(:,3),'o','LineWidth',0.5,'DisplayName','mean');
pp2.Color=c(14,:);
hold on;
pp3=plot(nwt2(39,2),nwt2(39,3),'-o','LineWidth',2,'DisplayName','$ZT_0$');
pp3.Color=c(14,:);
pp3.MarkerFaceColor=[0 0 1];

title('Average noise across periods');


l=legend([pp pp3]);
l.Location='bestoutside';

xlim([2*10^(-3) 10*10^(-3)])
xticks(2*10^(-3): 2.5*10^(-3): 10*10^(-3))

ylim([0 0.04]);
yticks(0:0.01:0.04)

ylabel('C.V.$^2$');
xlabel('1/[YFP]');

%% Saving - disabled
cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
fname='fig1G';
fig_save_font_20;