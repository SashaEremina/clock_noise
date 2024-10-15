close all; 
clearvars -except selpath;


%% Plotting
cd([selpath, '/data/noiseloops']);

%WT
nwt1_m=readmatrix('noiseloop_phasealigned2_WT (ΔlalA) [LL].csv');

figure; subplot(3,2,1);
c=winter(64);

for i=1:5
    if i<5
        if i>1 
            p(i)=plot(nwt1_m((i-1)*100+71+1:(i-1)*100+71+100,2),nwt1_m((i-1)*100+71+1:(i-1)*100+71+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
            p(i).Color=c(i*10,:);
        else
            p(i)=plot(nwt1_m(71:171,2),nwt1_m(71:171,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
            p(i).Color=c(i*10,:);
        end
    end
    hold on;
end

title('WT');
ax=gca;
ax.YAxis.Exponent=-3;
ylim([0 20*10^(-3)]); yticks(0:10*10^(-3):20*10^(-3));
xlim([1.5*10^(-3) 8*10^(-3)])


%% del_ldpA
nldpA_m=readmatrix('noiseloop_phasealigned2_ΔldpA [LL].csv');

subplot(3,2,2);

for i=1:5
    if i<5
       if i>1 
        p(i)=plot(nldpA_m((i-1)*100+91+1:(i-1)*100+91+100,2),nldpA_m((i-1)*100+91+1:(i-1)*100+91+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
       else
        p(i)=plot(nldpA_m(91:191,2),nldpA_m(91:191,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
       end
    else
        p(i)=plot(nldpA_m((i-1)*100+91+1:591,2),nldpA_m((i-1)*100+91+1:591,3),'LineWidth',2,'DisplayName',['period', '{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end


title('$\Delta$\it ldpA');
ylim([0 10*10^(-3)]); yticks(0:4*10^(-3):10*10^(-3));
ax=gca;
ax.YAxis.Exponent=-3;

%manually positioning the legend in place of the missing subplot
lgd=legend;
lgd.Position(1)=0.58;
lgd.Position(2)=0.15;


%% del_lalA
nlalA_m=readmatrix('noiseloop_phasealigned2_ΔlalA [LL].csv');

subplot(3,2,5);

for i=1:5 
    if i>1
        p(i)=plot(nlalA_m((i-1)*100+71+1:(i-1)*100+71+100,2),nlalA_m((i-1)*100+71+1:(i-1)*100+71+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
     else
        p(i)=plot(nlalA_m(71:171,2),nlalA_m(71:171,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
        
    end
    hold on;
end


title('$\Delta$\it lalA');
ylim([0 20*10^(-3)]); yticks(0:10*10^(-3):20*10^(-3));
ax=gca;
ax.YAxis.Exponent=-3;

%% del_pex
npex_m=readmatrix('noiseloop_phasealigned2_Δpex [LL].csv');

subplot(3,2,3);

for i=1:4
    if i>1
        p(i)=plot(npex_m((i-1)*100+61+1:(i-1)*100+61+100,2),npex_m((i-1)*100+61+1:(i-1)*100+61+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    else
        p(i)=plot(npex_m(61:161,2),npex_m(61:161,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end


title('$\Delta$\it pex');

ax=gca;
ax.YAxis.Exponent=-3;
ylim([10*10^(-3) 45*10^(-3)]); yticks(10*10^(-3):15*10^(-3):45*10^(-3));


%% del_prkE
nprkE_m=readmatrix('noiseloop_phasealigned2_ΔprkE [LL].csv');

subplot(3,2,4);

for i=1:4 
    if i<4
        p(i)=plot(nprkE_m((i-1)*100+71+1:(i-1)*100+71+100,2),nprkE_m((i-1)*100+71+1:(i-1)*100+71+100,3),'LineWidth',2,'DisplayName',['period','{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    else
        p(i)=plot(nprkE_m((i-1)*100+71+1:end,2),nprkE_m((i-1)*100+71+1:end,3),'LineWidth',2,'DisplayName',['period', '{ }', num2str(i)]);
        p(i).Color=c(i*10,:);
    end
    hold on;
end


title('$\Delta$\it prkE');
ax=gca;
ax.YAxis.Exponent=-3;
ylim([0 25*10^(-3)]); yticks(0:10*10^(-3):25*10^(-3));

%Figure styling
han=axes(figure(1),'visible','off');
han.XLabel.Visible='on';
han.YLabel.Visible='on';

ylabel(han,'C.V.$^2$');
xlabel(han,'1/[YFP]');

%% Saving
cd([selpath,'/figures/fig2']);
fname='fig_s2_3';
fig_save_font_20;