close all;
clearvars -except selpath;

%% 
cd([selpath, '/data/datasets/noisy_day']);
MY=readmatrix('WT_mother_mean_fluor.csv');
time_adjusted=readmatrix('WT_time_adjusted.csv');

t_light_int_h_adj=readmatrix('WT_time_light_adjusted.csv');
intensity=readmatrix('WT_light_intensity.csv');
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)]; 

%background subtraction
MY=MY-300;

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

k=(max(intensity)/max((max(MY))*1.4)); %adusting intensity range for visualisation purposes only

figure; 
A=area(t_light_int_h_adj, intensity/k);
A.FaceColor=[1 1 0];
A.FaceAlpha=0.2;


hold on; 
patch([-12 -12 0 0], [0 max(intensity/k)*1.4 max(intensity/k)*1.4 0], 'b'); ylim([0 1600])
alpha(0.15);

st=20;

y=mean(MY_smooth','omitnan');
y=y(st:end);

std_dev=std(MY_smooth','omitnan');
std_dev=std_dev(st:end);

a=max(max(time_adjusted));
x=time_adjusted;
x=x(st:end,13)'; %longest time-trace

keepIndex = ~isnan(y) & ~isnan(std_dev) & ~isnan(x);
y=y(keepIndex);
std_dev=std_dev(keepIndex);
x=x(keepIndex);

curve1 = y + std_dev;
curve2 = y - std_dev;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
hold on;
h(1)=fill(x2, inBetween, 'm','DisplayName','\sigma');
set(h(1),'facealpha',.3);

hold on; 
h(2)=plot(time_adjusted(st:end,94),MY_smooth(st:end,94),'m','LineWidth',2,'DisplayName','representative lineage');

xlim([- 12 120]);
legend([h(2) h(1)])
xticks(0:12:124);

ylim([0 1600]); yticks(0:250:1500);

yl(2)=max(intensity/k);
GR.m_cell_num(2)=surv(2);
hold on; text (5,yl(2)*1.25,strcat('n=',num2str(GR.m_cell_num(2))));

xlabel('Time (h)');
ylabel('Fluorescence (a.u.)');

%Plotting the light levels
yyaxis right
yticks(0:(40/36.9375)/8:40/36.9375); %approx
yticklabels({'0','5','10','15','20','25','30','35','40'}); %approx
ylabel ('Light intensity (\mumol m^{-2} s^{-1})');

%% Figure styling
ax=gca;
ax.YColor='k';

box on

%% Saving
cd([selpath,'/figures/fig6']);
fname='fig_s22A';
fig_save_font_20_ssf;