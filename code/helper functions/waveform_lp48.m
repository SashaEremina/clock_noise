%period estimation - simply by finding peaks
cellnum=find(isnan(MY(1,:)), 1 )-1;
time_pt_zero=find(time_adjusted(:,1)==0);

if isempty (time_pt_zero)
    time_pt_zero=1;
end

l=max(unique(floor(find(time_adjusted==max(max(time_adjusted)))/300)));
times_full=time_adjusted(:,l);

%work with smoothed data
MY_smoothing;

for i=1:cellnum
    [troughs, locs1]=findpeaks(-MY_smooth(time_pt_zero+5:end,i),'MinPeakDistance',50); %skip the 1st trough
    troughs=-troughs;
    wave(i).troughs=troughs;
    wave(i).tlocs=locs1;
    t_correct=times_full(time_pt_zero:end); %times_full instead of time_adjusted
    wave(i).ttimes=t_correct(locs1+5); %used to we locs - wrong!
    wave(i).tperiod=mean(diff(times_full(locs1+5))); %used to we locs - wrong!

    if wave(i).tperiod>50
        if find(diff(times_full(locs1))>40)>0 %a skipped peak -> re-do the analysis
            [troughs, locs1]=findpeaks(-MY_smooth(time_pt_zero+5:end,i),'MinPeakDistance',50); %need to adjust
            ... for non-linear time vector to around 10 %28 for 0.75 acquisition rate
                troughs=-troughs;
         
            wave(i).troughs=troughs;
            wave(i).tlocs=locs1;
            wave(i).ttimes=t_correct(locs1+5); %used to we locs - wrong!
            wave(i).tperiod=mean(diff(times_full(locs1+5))); %used to we locs - wrong!
        end
    end
    
    [peaks, locs2]=findpeaks(MY(time_pt_zero:end,i),'MinPeakDistance',50);
    wave(i).cellnum=i;
    wave(i).peaks=peaks;
    wave(i).plocs=locs2;
   
    wave(i).ptimes=t_correct(locs2);
    %wave(i).tperiod_std=std(diff(times_full(locs1)));
    
    wave(i).pperiod=mean(diff(times_full(locs2)));
    %wave(i).pperiod_std=std(diff(times_full(locs2)));
    
      if wave(i).pperiod>50
        if find(diff(times_full(locs2))>40)>0 %a skipped peak -> re-do the analysis
            [peaks, locs2]=findpeaks(MY(time_pt_zero:end,i),'MinPeakDistance',50); %need to adjust
            ... for non-linear time vector to around 10 %28 for 0.75 acquisition rate
         
           wave(i).peaks=peaks;
           wave(i).plocs=locs2;
           
           wave(i).ptimes=t_correct(locs2);
           %wave(i).tperiod_std=std(diff(times_full(locs1)));
           
           wave(i).pperiod=mean(diff(times_full(locs2)));
        end
      end
    
%     %debug
%     if wave(i).pperiod<23
%         disp ('why')
%     end
    
    for ii=1:min(length(peaks),length(troughs))
        amplitude(ii)=peaks(ii)-troughs(ii);
    end
    wave(i).amplitude=amplitude/2;
    %wave(i).amplitude_std=std(diff(times_full(amplitude(ii))));
end

prompt = 'What is the name of the dataset? ';
save(strcat('waveform_',input(prompt,'s'),'.mat'), 'wave')