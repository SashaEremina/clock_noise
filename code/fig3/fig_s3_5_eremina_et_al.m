close all;
clearvars -except selpath;

%% 
cd([selpath, '/simulations/posterior-Fig3/posterior-parameters']);

k_abc=readmatrix('posteriordist_k_ABC.csv');
k_dephos=readmatrix('posteriordist_k_dephos.csv');
k_off=readmatrix('posteriordist_k_off.csv');
k_on=readmatrix('posteriordist_k_on.csv');
k_phos=readmatrix('posteriordist_k_phos.csv');

figure; 
cd([selpath,'/figures/fig3']);
fig_general_code_horisontal_no_plot;

hold on; subplot(1,5,5); plot(k_abc(:,1),k_abc(:,2),'linewidth',2);
xticks(0:2:10); yticks (0:0.05:0.3); xtickangle(45);
xlabel('$k_{ABC}(h^{-1})$');
ylabel('posterior');

hold on; subplot(1,5,4); plot(k_off(:,1),k_off(:,2),'linewidth',2);
xticks(0:0.02:0.08); yticks (0:5:25); xtickangle(45);
xlabel('$k_{off}(h^{-1})$');
ylabel('posterior');

hold on; subplot(1,5,3); plot(k_on(:,1),k_on(:,2),'linewidth',2);
xticks(0:0.01:0.04); yticks (0:10:40); xtickangle(45);
xlabel('$k_{on}(h^{-1})$');
ylabel('posterior');

hold on; subplot(1,5,2); plot(k_phos(:,1),k_phos(:,2),'linewidth',2);
xticks(0:0.2:0.8); yticks (0:1:4); xtickangle(45);
xlabel('$k_{phos}(h^{-1})$');
ylabel('posterior');

hold on; subplot(1,5,1); plot(k_dephos(:,1),k_dephos(:,2),'linewidth',2);
xticks(0:0.2:0.8); yticks (0:0.5:2.5); xtickangle(45);
xlabel('$k_{dephos}(h^{-1})$');
ylabel('posterior');

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s3_5';

fig_save_horizontal;
