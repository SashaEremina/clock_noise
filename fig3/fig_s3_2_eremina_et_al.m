close all;
clearvars -except selpath;

%establishing the color palette 
cc=[254,237,222;
253,190,133;
253,141,60;
217,71,1];

cc=cc/255;

%% Plotting:
%KaiC-R215C OLD - IS THIS THE RIGHT DATASET?

cd([selpath, '/data/datasets/KaiC-R215C_high_LL_rep1']);
MY=readmatrix('KaiC-R215C_mother_mean_fluor.csv');
 
%background subtraction
MY=MY-200;
 
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
subplot(3,2,3); yl=[0 450]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:150:450);
xlim([-12 106]); xticks(0:24:144);
ylim([0 450]); 

text(-10, yl(2)*0.85,strcat('n=',num2str(surv(2))));

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
    hL(ii).Color(1:3)=cc(2,:);
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end

title('KaiC-R215C high LL'); set(gca,'Fontsize', 9);

%% WT
cd([selpath, '/data/datasets/WT_high_LL']);
MY=readmatrix('WT-reporter_mother_mean_fluor.csv');

%background subtraction
MY=MY-200;
 
surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('WT-reporter_time_adjusted.csv');
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
subplot(3,2,1); yl=[0 800]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:250:650);
xlim([-12 106]); xticks(0:24:144);
ylim([0 800]); 


text(-10, yl(2)*0.85,strcat('n=',num2str(surv(2))));


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0, 1);
if isempty(st)
    st=1;
end

st=1;

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)=cc(1,:); %remove if necessary
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end


title('WT high LL'); set(gca,'Fontsize', 9);

%% KaiC-T495A

cd([selpath, '/data/datasets/KaiC-T495A_high_LL_rep1']);

MY=readmatrix('KaiC-T495A_mother_mean_fluor.csv');

%background subtraction
MY=MY-200;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('KaiC-T495A_time_adjusted.csv');
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
subplot(3,2,5); yl=[0 600]; patch_universal(time_adjusted(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(0:200:750);
xlim([-12 106]); xticks(0:24:144);
ylim([0 600]); yticks(0:200:600);

text(-10, yl(2)*0.85,strcat('n=',num2str(surv(2))));


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted(:,1)==0);
if isempty(st)
    st=min(min(time_adjusted));
end

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)=cc(3,:); %remove if necessary
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end


title('KaiC-T495A high LL'); set(gca,'Fontsize', 9);


%% LP48

cd([selpath, '/data/datasets/KaiC-A251V_med_LL']);
MY=readmatrix('LP48_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('LP48_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

time_adjusted=time_adjusted+24;


start_p=find(time_adjusted(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end

%waveform_analysis - for alignment by the 1st trough
D=dir('waveform*');
if ~isempty(D)
    load('waveform_lp48.mat')
else
    waveform_lp48; %lp48 is the input
end

t1=[]; %first trough
for i=1:size(wave,2)
    t1(i)=wave(i).ttimes(1);
end

tm=nanmean(t1); %mean trough location
tt=[];

%alignment indices
for i=1:size(t1,2)
    tt(i)=tm-t1(i);
end

time_adjusted2=time_adjusted;
for i=1:size(t1,2)
    time_adjusted2(:,i)=time_adjusted2(:,i)+tt(i);
end

start_p=find(time_adjusted2(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


figure(1); 
subplot(3,2,4); yl=[100 3800]; patch_universal(time_adjusted2(start_p:end,:),'night',MY(start_p:end,:),1,yl);
yticks(1000:1000:3000);
xlim([0 120]); xticks(0:24:144);
ylim([100 3800]); xlim([0 106]);

text(10, yl(2)*0.85,strcat('n=',num2str(surv(2))));


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
    hL(ii)=plot(time_adjusted2(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)= [0.4940 0.1840 0.5560];
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end

title('LP48 medium LL'); set(gca,'Fontsize', 9);

%% SP16

cd([selpath, '/data/datasets/KaiC-R393C_med_LL_rep2']); 

MY=readmatrix('SP16_2_mother_mean_fluor.csv');

%background subtraction
MY=MY-300;

surv=[1,ceil(find(~isnan(MY), 1, 'last' )/300)];

time_adjusted1=readmatrix('SP16_2_time_adjusted.csv');
time_adjusted=NaN(300,1000);
for i=1:surv(2)
    time_adjusted(1:size(time_adjusted1,2),i)=time_adjusted1;
end

%waveform_analysis - for alignment by the 1st trough
D=dir('waveform*');
if ~isempty(D)
    load('waveform_sp16.mat')
else
    waveform_sp16; %sp16 is the input
end


t1=[]; %first trough
for i=1:size(wave,2)
    t1(i)=wave(i).ttimes(1);
end

tm=nanmean(t1); %mean trough location
tt=[];

%alignment indices
for i=1:size(t1,2)
    tt(i)=tm-t1(i);
end

time_adjusted2=time_adjusted;
for i=1:size(t1,2)
    time_adjusted2(:,i)=time_adjusted2(:,i)+tt(i);
end

start_p=find(time_adjusted2(:,1)==0);
st=start_p;

if isempty(start_p) %entrainment was done separately / no entrainment
    start_p=1;
    st=start_p;
end


figure(1); 
subplot(3,2,6); yl=[400 2400]; patch_universal(time_adjusted2(start_p:end,:),'night',MY(start_p:end,:),0,yl);
yticks(600:600:2200);
xlim([0 120]); xticks(0:24:144);
ylim([400 2400]);
xlim([0 106]);

text(10, yl(2)*0.85,strcat('n=',num2str(surv(2))));


MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

st=find(time_adjusted2(:,1)==0);

if isempty(st)
    st=1;
end

for ii=1:surv(2)
    hL(ii)=plot(time_adjusted2(st:end,ii),MY_smooth(st:end,ii)); hold on
    hL(ii).Color(1:3)=cc(4,:); 
    hL(ii).Color(4) = 0.6;
    hL(ii).LineWidth=1;
end

title('SP16 medium LL'); set(gca,'Fontsize', 9);

%% Figure styling
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
xlabel(han,'Time (h)');
han.YLabel.Visible='on';
ylabel(han,'Fluorescence (a.u.)');


y1=han.YLabel.Position;
y1(1)=y1(1)*1.4;
han.YLabel.Position=y1;

%% Saving
cd([selpath,'/figures/fig3']);
fname='fig_s3_2';
fig_save_font_20;