
if max(max(MY))>450
    MY=MY-200; %background subtraction
end

MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY)
    a=find(isnan(MY(:,i)), 1 );
    MY_smooth(1:a,i)=smooth(MY(1:a,i),6); %visualisation only
end

st=find(time_adjusted(:,1)==0);

figure;
patch_universal_paper(time_adjusted,'night',MY_smooth,1,[0 950]); ylim([0 950]);
hold on; 
p=patchline(time_adjusted(st:end,:),MY_smooth(st:end,:),'EdgeColor','b','EdgeAlpha',0.2);

hold on; 
%an example of a single-cell trace highlighted
h(2)=plot(time_adjusted(st:end,13),MY_smooth(st:end,13),'b','LineWidth',2,'DisplayName','Representative lineage');
legend(h(2));

%axes boundaries
ylim([0 500]);
xlim([-12 144]);
xticks(0:24:144);
yticks(0:100:500)

xlabel('Time (h)');
ylabel ('Fluorescence (a.u.)');