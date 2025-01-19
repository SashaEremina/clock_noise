%adjusting cell length from Metamorph units to um
if max(max(len))>100
    len=len./15.5;
end

len_smooth=NaN(size(len,1),size(len,2));
for i=1:length(len)
    a=find(isnan(len(:,i)), 1 );
    len_smooth(1:a,i)=smooth(len(1:a,i));
end

patch_universal(time_adjusted,'night',len_smooth,1,[0,12]);
hold on; 

st=find(time_adjusted(:,1)==0);
p=patchline(time_adjusted(st:end,:),len_smooth(st:end,:),'EdgeColor','b','EdgeAlpha',0.2);

%an example of a single-cell trace highlighted
a=12;
y=len_smooth(:,a);
x=time_adjusted(:,a)';
h(2)=plot(x(st:end), y(st:end), 'b', 'LineWidth', 2,'DisplayName','representative lineage');
[vals,inds]=findpeaks(y(st:find(~isnan(y), 1, 'last' )-1),x(st:find(~isnan(y), 1, 'last' )-1)');
hold on; h(3)=plot(inds, vals,'bv','LineWidth',2,'MarkerSize',6,'DisplayName','divisions detected');

yl_1=min(y)*0.8;
yl_2=max(y)*1.2;

ylim([yl_1 yl_2])
xlim([-12 144]);xticks(0:24:144);

xlabel('Time (h)');
ylabel ('Cell length ($\mu$m)'); 

legend(h(2:3));

ylim([2 11])
yticks(4:2:10);

box on; grid off;
