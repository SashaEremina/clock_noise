%example input: daynum=[1,2,4]for plotting the data from day 1,4, and 6 of
%each month in the dataset

function [int_a,t_nov,l_nov, int2, t_int, int1]=light_input_caribbean(daynum)
load('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\data\light_raw.mat'); 
ind=(site=='Abanico');

v_ind=(sum(ind')==7);

mon=unique(month(v_ind)); %how many months we have in a dataset
mon=1; %January

b=find(diff(v_ind)~=0); 

formatSpec = 'hh:mm';
dInh=[];
for i=1:length(time_utc)
    d = duration(time_utc(i,:), 'InputFormat', formatSpec, 'Format', formatSpec);
    format longg
    dInh(i) = hours(d);
end

    
mon_n={'January','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'};

t_nov=NaN(length(daynum),144); %144 comes from certain acquisition frequency in the datasets and can be adjusted
l_nov=NaN(length(daynum),144);

    for dd=1:length(daynum)
        d1=find(day==daynum(dd));
        if size(b,2)==1
            d1=d1(d1<b);
        elseif size(b,2)>1
            disp('check your dataset parsing!')
        end    
        
       md=intersect((find(month==mon)),d1);
       t_nov(dd,1:length(md))=dInh(md);
       l_nov(dd,1:length(md))=light_corr(md);

    end
    
int=[];
int1=[]; %intensity for the first few hours before the trough time

n=ceil(length(daynum)/7);

t_nov(t_nov==0)=24;

cc=colormap(jet(7));

%comparing to an 'ideal' lightwave, d1
x=[6:12/72:18];
y=sin((x-6)/(12/pi))*70; %ideal lightwave on day 1



for nn=0:1:n-1
  
    if nn<n-1
        for i=5*nn+1:5*(nn+1)
            hold on;
            pp(i)=plot(t_nov(i,:),l_nov(i,:),'LineWidth',2,'DisplayName',char(strcat('Day',{' '},num2str(daynum(i)))));
            pp(i).Color=cc(i,:);
            int(i)=trapz(t_nov(i,:),l_nov(i,:));
            hold off;
        end
   else
       for i=5*nn+1:length(daynum)
        hold on;
        pp(i)=plot(t_nov(i,:),l_nov(i,:),'LineWidth',2,'DisplayName',char(strcat('Day',{' '},num2str(daynum(i)-6))));
        pp(i).Color=cc(i,:);
        int(i)=trapz(t_nov(i,:),l_nov(i,:));
        int1(i)=trapz(t_nov(i,1:58),l_nov(i,1:58)); %until ca 10 am
        
        tt=t_nov(i,:);
        t_int(i)=max(tt(l_nov(i,:)>0))-min(tt(l_nov(i,:)>0));
        hold off;
        
        s=find(t_nov(i,:)==6); 
        e=find(t_nov(i,:)==18);
        figure; plot(x,y,t_nov(i,s:e),l_nov(i,s:e)); close;
        int2(i)=trapz(x,y-l_nov(i,s:e))/trapz(x,y);
        
         
       end
    end
    legend
    xlabel('Circadian time (h)');
    xticks(0:2:24);
    xlim([0 24]);
    ylabel('Light Intensity ($\mu$ E $m^{-2}$ $s^{-1}$)');

    
    title(strcat(char(mon_n(mon)),{' '},'2017, ',{' '},'3 m underwater'));
end    

 int_m=mean(int);
 int_a=[int];
end

