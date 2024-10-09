close all; clear all;

%% load the data
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\noiseloops']);

%1. WT under low LL
nwt1=readmatrix('noiseloop_phasealigned_WT (ΔKaiBC) [low LL].csv');
nwt1_m=readmatrix('noiseloop_phasealigned2_WT (ΔKaiBC) [low LL].csv');

%2. WT under high LL
nwt3=readmatrix('noiseloop_phasealigned_WT (ΔKaiC-R215C) [high LL].csv');
nwt3_m=readmatrix('noiseloop_phasealigned2_WT (ΔKaiC-R215C) [high LL].csv');

%% Fig.S1_6A: Plotting - low LL

close all
figure; subplot(2,1,2);

c=summer(64);

for i=1:5 
    if i<5
        p(i)=plot(nwt1_m(i*100:i*100+100,2),nwt1_m(i*100:i*100+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    else
        p(i)=plot(nwt1_m(i*100:end,2),nwt1_m(i*100:end,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end

lgd=legend;
lgd.Location='bestoutside';

xlim([0.4*10^(-3) 1.4*10^(-3)])
xticks(0.4*10^(-3): 0.25*10^(-3): 1.4*10^(-3))

ylim([0.02 0.05]);
yticks(0.02:0.01:0.05)

ylabel('C.V.$^2$');
xlabel('1/[YFP]');

%title('Average noise per period - low LL')
title('Noise loop per period - low LL')

hold on; subplot(2,1,1);
pp=plot(nwt1(:,2),nwt1(:,3),'-','LineWidth',2,'DisplayName','mean'); %'DisplayName','medium LL'
pp.Color=c(14,:);
hold on;
pp2=plot(nwt1(:,2),nwt1(:,3),'o','LineWidth',0.5,'DisplayName','mean'); %'DisplayName','medium LL'
pp2.Color=c(14,:);
hold on;
pp3=plot(nwt1(39,2),nwt1(39,3),'-o','LineWidth',2,'DisplayName','$ZT_0$'); %'DisplayName','medium LL'
pp3.Color=c(14,:);
pp3.MarkerFaceColor=[0 0 1];

%title('Average noise across periods - low LL');
title('Noise loop - low LL');

l=legend([pp pp3]);
l.Location='bestoutside';

xlim([4*10^(-4) 14*10^(-4)])
xticks(4*10^(-4): 2.5*10^(-4): 14*10^(-4))

ylim([0.02 0.05]);
yticks(0.02:0.01:0.05)


ylabel('C.V.$^2$');
xlabel('1/[YFP]');

% Saving - disabled
cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
fname='fig_s1_6B';
fig_save_font_20;

%% Fig.S1_6B: Plotting - high LL
close all
figure; subplot(2,1,2);

c=spring(64);

for i=1:4 
    if i<5
        p(i)=plot(nwt3_m(i*100+1:i*100+100,2),nwt3_m(i*100+1:i*100+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    else
        p(i)=plot(nwt3_m(i*100+1:end,2),nwt3_m(i*100+1:end,3),'LineWidth',2,'DisplayName',['period', '{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end

lgd=legend;
lgd.Location='bestoutside';

xlim([1.3*10^(-3) 7.6*10^(-3)])
xticks(1.3*10^(-3): 2.5*10^(-3): 7.6*10^(-3))

ylim([0 0.05]);
yticks(0:0.015:0.05)

ylabel('C.V.$^2$');
xlabel('1/[YFP]');
title('Noise loop per period - high LL')


hold on; subplot(2,1,1);
pp=plot(nwt3(:,2),nwt3(:,3),'-','LineWidth',2,'DisplayName','mean'); 
pp.Color=c(14,:);
hold on;
pp2=plot(nwt3(:,2),nwt3(:,3),'o','LineWidth',0.5,'DisplayName','mean'); 
pp2.Color=c(14,:);
hold on;
pp3=plot(nwt3(39,2),nwt3(39,3),'-o','LineWidth',2,'DisplayName','$ZT_0$');
pp3.Color=c(14,:);
pp3.MarkerFaceColor=[0 0 1];

%title('Average noise across periods - high LL');
title('Noise loop - high LL')


l=legend([pp pp3]);
l.Location='bestoutside';

xlim([1.3*10^(-3) 7.4*10^(-3)])
xticks(1.3*10^(-3): 2.5*10^(-3): 7.4*10^(-3))

ylim([0 0.05]);
yticks(0:0.015:0.05)

ylabel('C.V.$^2$');
xlabel('1/[YFP]');

% Saving - disabled
cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig1');
fname='fig_s1_6B';
fig_save_font_20;