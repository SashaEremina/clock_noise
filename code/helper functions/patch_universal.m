%inputs: 
%daynight='day' or 'night', depending on what you want to patch;
%whatplot=MY, or any other type of data - used to set ylim;
%entrain=1 or 0;

function patch_universal(time_adjusted,daynight,whatplot,entrain,yl)

dur=max(max(time_adjusted));
if ~exist('yl','var')
    y_min=min(min(whatplot))*0.6;
    y_max=max(max(whatplot))*1.1;
else
    y_min=yl(1);
    y_max=yl(2);
end    


n_st=[12:24:ceil(dur/24)*24];
n_end=[24: 24: ceil(dur/24)*24];

d_st=[0:24:ceil(dur/24)*24];
d_end=[12: 24: ceil(dur/24)*24];

if strcmp(daynight,'night')  
    for i=1:length(n_end)
        hold on; patch([n_st(i) n_st(i) n_end(i) n_end(i)], [y_min y_max y_max y_min], 'b'); alpha(0.1);
    end


elseif strcmp(daynight,'day')  
    for i=1:length(d_end)
        hold on; patch([d_st(i) d_st(i) d_end(i) d_end(i)], [y_min y_max y_max y_min], 'y'); alpha(0.1);
    end
end 

if entrain==1    
    hold on; patch([-12 -12 0 0], [y_min y_max y_max y_min], 'b'); alpha(0.1);
    hold on; patch([-12 -12 0 0], [y_min y_max y_max y_min], 'b'); alpha(0.1);
    hold on; patch([-12 -12 0 0], [y_min y_max y_max y_min], 'b'); alpha(0.1);
end
 
end