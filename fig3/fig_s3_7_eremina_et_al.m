close all;
clearvars -except selpath;

%%

figure(1)
subplotLayout = [2,2];
ax = gobjects(fliplr(subplotLayout));
for i = 1:prod(subplotLayout)
    ax(i) = subplot(subplotLayout(1),subplotLayout(2),i);
end
set(ax,'Units','Normalize');
ax = ax';
axPos = cell2mat(get(ax, 'Position'));
axPos(:,4) = axPos(:,4).*.98;
set(ax, {'Position'}, mat2cell(axPos, ones(numel(ax),1), 4));
axPos = cell2mat(get(ax(:,1), 'Position'));
axUpperPos = sum(axPos(:,[2,4]),2);  
axPos = cell2mat(get(ax(1,[1,end]),'Position'));
axCenterPos = mean([axPos(1,1), sum(axPos(2,[1,3]))]);
titles = {'KaiC-R215C medium LL', 'KaiC-R215C high LL'};  
titleHandles = gobjects(numel(titles),1); 
for i = 1:numel(titles)
    titleHandles = annotation('textbox','String',titles{i}, ...
        'Position', [axCenterPos, axUpperPos(i), 0, 0], ... 
        'HorizontalAlignment', 'center','VerticalAlignment','bottom',...
        'LineStyle','none','FitBoxToText','on', ...
        'FontWeight',ax(1).Title.FontWeight, ... 
        'FontSize', ax(1).Title.FontSize, ...    
        'FontName', ax(1).Title.FontName, ...  
        'Color', ax(1).Title.Color);            
end

%establishing the color palette 
cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

%% Plotting:

%KaiC-R215C - high LL
cd([selpath, '/data/datasets/KaiC-R215C_high_LL_rep2']);

MY=readmatrix('KaiC-R215C_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('KaiC-R215C_time_adjusted.csv');


time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end

figure(1); 
subplot(2,2,3); yl=[0 2200]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(600:800:2200);
xlim([-12 106]); xticks(0:24:144);
ylim([0 2200]); 

text(-10, yl(2)*0.9,strcat('n=',num2str(surv(2))));

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    %st=min(min(time_adjusted));
    st=1;
end

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)=cc(2,:);
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end

xlabel('Time (h)');

%% KaiC med LL

cd([selpath, '/data/datasets/KaiC-R215C_med_LL_rep1']);

MY=readmatrix('KaiC-R215C_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('KaiC-R215C_time_adjusted.csv');


time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end

figure(1); 
subplot(2,2,1); yl=[0 2200]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(600:800:2200);
xlim([-12 106]); xticks(0:24:144);
ylim([0 2200]); 

text(-10, yl(2)*0.9,strcat('n=',num2str(surv(2))));

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=1;
end

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)=cc(3,:);
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end

%% Pt 2 - ACFs

cd([selpath, '/data/meanautocovariance/mean_subtract']);
A_hLL = readmatrix('autocov_msub_KaiC-R215C (2) [high LL].csv'); %high LL repeat
A_mLL= readmatrix('autocov_msub_KaiC-R215C [LL].csv'); %med LL


%autocov -> acf
A_hLL(:,2)=A_hLL(:,2)./max(A_hLL(:,2));
A_mLL(:,2)=A_mLL(:,2)./max(A_mLL(:,2));

hold on;

subplot(2,2,4);
p1=plot(A_hLL(:,1),A_hLL(:,2),'DisplayName','KaiC-R215C high LL'); hold on
p1.LineWidth=3; p1.Color=cc(2,:);

xlim([-72 72]); xticks(-96:24:96); xtickangle(45)
ylim([-1.2 1.2]); xlabel('Lag (h)'); ylabel ('Autocorrelation')

subplot(2,2,2);
p2=plot(A_mLL(:,1),A_mLL(:,2),'DisplayName','KaiC-R215C med LL'); hold on
p2.LineWidth=3; p2.Color=cc(3,:);

xlim([-72 72]); xticks(-96:24:96); xtickangle(45)
ylim([-1.2 1.2]); ylabel ('Autocorrelation')

%% Figure styling
ax = axes(figure (1));
han = gca;
han.Visible = 'off';

ylabel('Fluorescence (a.u.)')
han.YLabel.Visible = 'on';

y1=han.YLabel.Position;
y1(1)=y1(1)*1.6;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s3_7';
fig_save_font_20;


