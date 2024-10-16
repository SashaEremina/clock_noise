close all;
clearvars -except selpath;

%% 
cd([selpath, '/data/hilbertphase']);
ph=readmatrix('hilbertphase_WT [LL].csv');

ph=ph(:,3:end);

figure;
h(1)=plot(smooth(ph(5,1:end))-min(smooth(ph(5,1:end))),'b','LineWidth',2,'DisplayName','cumulative running phase');

x=(1:1:size(ph(5,1:end),2));
y=x*1/32+ph(5,4)-5/32;
hold on; 
h(2)=plot(x,y-min(y),'g--', 'LineWidth', 2,'DisplayName','perfect phase');

tt=x;
t2=[tt fliplr(tt)];
inbetween=[ph(5,1:end)-min(smooth(ph(5,1:end))),fliplr(y-min(y))];
h(3)=fill(t2,inbetween,'b','FaceAlpha',0.2);

legend({sprintf('cumulative \n running phase'),'perfect phase','phase diffusion'},'Location','BestOutside');

xlabel('Time (h)');
xticks(0:24:144); 
ylabel('Phase, $${\phi}$$'); 

xlim([0 132]); 
title('Phase diffusion and robustness');

%% Saving
cd([selpath,'/figures/fig1']);
fname='fig_s1_4B';
fig_save_font_20;