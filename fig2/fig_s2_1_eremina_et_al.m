close all;

%loading the data
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\robustness']);
prkE=readmatrix('robustness_ΔprkE [LL].csv');
prkE(19,:)=[]; %removing the sick cell;

pex=readmatrix('robustness_Δpex [LL].csv');
ldpA=readmatrix('robustness_ΔldpA [LL].csv');
lalA=readmatrix('robustness_ΔlalA [LL].csv');
WT=readmatrix('robustness_WT (ΔlalA) [LL].csv');


%establishing the color palette
cp=[174,1,126; 166,206,227;
31,120,180;
178,223,138;
51,160,44];

cp=cp./255;


%establishing the data structures
w1=[ldpA(:,1)']; %del_ldpA
w2=[pex(:,1)']; %del_pex
w3=[prkE(:,1)']; %del_prkE
w4=[lalA(:,1)']; %del_lalA
w5=[WT(:,1)']; w5=rmoutliers(w5,'percentiles',[3 100]);

%statistical analysis of the period differences
[p1,h1]=ranksum(w5,w1);
[p2,h2]=ranksum(w5,w2);
[p3,h3]=ranksum(w5,w3);
[p4,h4]=ranksum(w5,w4);


%plotting
w=[w1,w2,w3,w4,w5];
strain={};
for i=1:length(w)
    if i<=length(w1)
        strain{i}='$${\Delta}$$\it ldpA';
    elseif i<=length(w1)+length(w2)    
        strain{i}='$${\Delta}$$\it pex';
    elseif i<=length(w1)+length(w2)+length(w3)  
        strain{i}='$${\Delta}$$\it prkE';
   elseif i<=length(w1)+length(w2)+length(w3)+length(w4)  
        strain{i}='$${\Delta}$$\it lalA';
    else    
        strain{i}='WT';
    end
end
        

figure; 
v=violinplot(w,strain,'Width',0.3,'GroupOrder',{'WT' '$${\Delta}$$\it ldpA'  '$${\Delta}$$\it pex' '$${\Delta}$$\it prkE' '$${\Delta}$$\it lalA'},'ShowNotches',false,'ViolinAlpha',0.3,'ShowData',false,...
    'ViolinColor',[cp(1,:); cp(2,:);cp(3,:);cp(4,:);cp(5,:)]);         

ylabel('Period (h)');
ylim([20 30])
xtickangle(45);

%plotting the statistics
sigstar({{'WT','$${\Delta}$$\it ldpA'},{'WT','$${\Delta}$$\it pex'},{'WT','$${\Delta}$$\it prkE'},{'WT','$${\Delta}$$\it lalA'}},[p1,p2,p3,p4])


%% Saving - disabled
cd(['C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures\fig2']);
fname='fig_s2_1';
fig_save_font_20;