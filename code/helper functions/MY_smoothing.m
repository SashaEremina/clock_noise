%MY_smooth
MY_smooth=NaN(size(MY,1),size(MY,2));
for i=1:length(MY);
a=min(find(isnan(MY(:,i))));
MY_smooth(1:a,i)=smooth(MY(1:a,i));
end

MY_m=nanmean(MY_smooth');
l1=min(find(isnan(MY_m)));
l2=ceil(min(find(time_adjusted==max(max(time_adjusted))))/300);

tm=time_adjusted(1:l1,l2);
MY_m=MY_m(1:l1);
