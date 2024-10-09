close all;clear all;

cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\simulations\p2pStatistics\noisydaySupplement'])

d=[1 2 3 4 5 6];

n_exp=readmatrix('LDexp_noisyday.csv');
sq_exp=readmatrix('LDexp_squarewave.csv');

n_sim=readmatrix('LDsim_noisyday.csv');
sq_sim=readmatrix('LDsim_squarewave.csv');

figure(1); subplot (2,1,1); hold on;
p(1)=errorbar(d(1:5)-0.07,n_exp(1:5,1),n_exp(1:5,1).*n_exp(1:5,2),'om','LineWidth',1,'DisplayName','noisy data'); hold on;
p(2)=errorbar(d(1:5)+0.07,n_sim(:,1),n_sim(:,1).*n_sim(:,2),'oy','LineWidth',1,'DisplayName','noisy sim'); hold on;

p(2).Color=[0 0.447 0.741];
legend('Location','BestOutside');
xticks(1:1:5);
ylim([4.5 8]); yticks(5:1:8);

figure(1); subplot (2,1,1); hold on;
p(3)=errorbar(d(1:5)+0.15,sq_exp(1:5,1),sq_exp(1:5,1).*sq_exp(1:5,2),'or','LineWidth',1,'DisplayName','square data'); hold on;
p(4)=errorbar(d(1:5)+0.22,sq_sim(1:5,1),sq_sim(1:5,1).*sq_sim(1:5,2),'oy','LineWidth',1,'DisplayName','square sim'); hold on;

p(3).Color=[0.85 0.325 0.098];
p(4).Color=[0.929 0.694 0.125];
legend('Location','BestOutside');
xticks(1:1:5);
ylim([4.5 8]); yticks(5:1:8);
ylabel('Mean trough time (h)');


hold on;
subplot(2,1,2);

dd(1)=plot(d(1:5),n_exp(1:5,2),'om','LineWidth',1,'DisplayName','noisy data'); hold on;
dd(2)=plot(d(1:5),n_sim(:,2),'ob','LineWidth',1,'DisplayName','noisy sim'); hold on;
dd(3)=plot(d(1:5)+0.1,sq_exp(1:5,2),'ob','LineWidth',1,'DisplayName','square data'); hold on;
dd(4)=plot(d(1:5)-0.1,sq_sim(1:5,2),'om','LineWidth',1,'DisplayName','square sim'); hold on;

dd(2).Color=[0 0.447 0.741];
dd(3).Color=[0.85 0.325 0.098];
dd(4).Color=[0.929 0.694 0.125];

for d=1:4
    dd(d).MarkerFaceColor=dd(d).Color;
end


%% Figure styling
xlabel('Day ($\#$)');
xlim([0.8 5.5]); xticks(1:1:5);
ylim([0 0.3]); ylabel({'C.V. (MTT)'});
legend ('Location','BestOutside');
ylabel({'C.V. (MTT)'});


%Saving - disabled
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig6']);
fname='fig_s6_2B';
fig_save_font_20;