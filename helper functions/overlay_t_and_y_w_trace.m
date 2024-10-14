function overlay_t_and_y_w_trace(s)

%figure;

%intro params
max_frames=100;
traces_y=1;
frac_c_tot=189;
frac_c_start=1;
f_channel1='y';
color_y1=1;

f_channel2='r';
color_y2=0;

r_b=270; %bottom boundary


%image1
if f_channel1=='s'
    z=s(1).Lc_c;
elseif f_channel1=='p'
    z=s(1).preg;
elseif f_channel1=='r'
    z=s(1).rreg;
elseif f_channel1=='y'
    z=s(1).yreg;
end


zp=s(1).Lc_c;
im_s=size(z);


if color_y1==1 && f_channel1=='s'
    tile=zeros(r_b,im_s(2)*frac_c_tot,3);
else
    tile=zeros(r_b,max_frames);
end


t_b=0; %beginning of tile
t_e=0; %end of tile

sL2=[]; %size L2

t_b=0; %beginning of tile
t_e=0; %end of tile

if frac_c_start>1
    maxk=frac_c_tot;
else
    maxk=frac_c_tot+frac_c_start-1;
end


for k=frac_c_start:2:(maxk)
    
    L=z(:,:,k);
    %L=z(:,:,k);
    
    %Using the mask to determine boundaries
      Lp2=zp(:,:,k);
      r2=regionprops(Lp2);
      r2_bb1=[];
      r2_bb2=[];
      for i=1:size(r2,1)
          if r2(i).Area>100
              r2_bb1(end+1)=r2(i).BoundingBox(1);
              r2_bb2(end+1)=r2(i).BoundingBox(1)+r2(i).BoundingBox(3);
          end
      end
      
        %r2_bb1_a=r2_bb1; %all left borders
        %r2_bb2_a=r2_bb2; %all right borders
        
        r2_bb1=ceil(min(r2_bb1));
        r2_bb2=floor(max(r2_bb2));
   
    %Using YFP channel      
      Lp=zp(:,:,k);
      r=regionprops(Lp);
      r_bb1=[];
      r_bb2=[];
      for i=1:size(r,1)
          if r(i).Area>100
              r_bb1(end+1)=r(i).BoundingBox(1);
              r_bb2(end+1)=r(i).BoundingBox(1)+r(i).BoundingBox(3);
          end
      end
      
      r_bb1=ceil(min(r_bb1));
      r_bb2=floor(max(r_bb2));
      L2=L(:,r_bb1:r_bb2,:);
      
      sL2(end+1)=size(L2,2);
      
      sum_c=sum(Lp2); %using the segmentation mask to find the left boundary
      r_bb1=min(find(sum_c>0));
      r_bb2=max(find(sum_c>0));
      
      sum_r=sum(Lp2,2); %using the segmentation mask to find the top boundary
      r_top=min(find(sum_r>0)-2); 
      
      L2=Lp(r_top:r_top+r_b,r_bb1:r_bb2-1,:);
      
      
       L2g=mat2gray(L2);
       %BB=imbinarize(L2g);
       BB=L2g;
       BB2=imerode(BB,strel('disk',1,4));
       if k==159
           BB2=BB;
       end
       
       [B,~] = bwboundaries(BB2,'noholes');
       hold on
       
       ind=500;
       for tt=1:length(B)
           if B{tt,1}(1)<ind
               ind=B{tt,1}(1);
               ind_tt=tt;
           end
       end
               
       boundary = B{ind_tt};
        
        plot(1+boundary(:,2)+t_e, boundary(:,1), 'w', 'LineWidth', 0.5);

       
       t_e=size(L2,2)+t_b+1;
       t_b=t_e;
       
       hold off;
    
  
end
   
end
