function overlay_t_and_y(s)

%intro params
max_frames=100; %per tile
traces_y=1;
frac_c_tot=189; %total frame number 
frac_c_start=1; 
f_channel1='y';
color_y1=1;

f_channel2='r';
color_y2=0;

r_b=242; %bottom boundary


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

sL2=[];

if frac_c_start>1
    maxk=frac_c_tot;
else
    maxk=frac_c_tot+frac_c_start-1;
end
     
for k=frac_c_start:2:(maxk)
    
    L=z(:,:,k);
    
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
      

        r2_bb1=ceil(min(r2_bb1));
        r2_bb2=floor(max(r2_bb2));

        L22=L(:,r2_bb1:r2_bb2,:);
       
    
    
    %Using YFP channel      
      Lp=z(:,:,k);
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
      r_top=min(find(sum_r>0))-2; 
      
      if r_top==0
          r_top=1;
      end
      
      if r_top+r_b>size(L,1)
          L2=L(r_top:end,r_bb1:r_bb2,:);
      else
          L2=L(r_top:r_top+r_b,r_bb1:r_bb2,:);
      end
      t_e=size(L2,2)+t_b;
        
    tile(1:size(L2,1),1+t_b:t_e,:)=L2;
    t_b=t_e;
    
end

tile=tile(1:r_b,:,:);
tile_y=tile;




%image2
if f_channel2=='s'
    z=s(1).Lc_c;
elseif f_channel2=='p'
    z=s(1).preg;
elseif f_channel2=='r'
    z=s(1).rreg;
elseif f_channel2=='y'
    z=s(1).yreg;
end


im_s=size(z);

if color_y2==1 && f_channel2=='s'
    tile=zeros(r_b,im_s(2)*frac_c_tot,3);
else
    tile=zeros(r_b,max_frames);
end



t_b=0; %beginning of tile
t_e=0; %end of tile

if frac_c_start>1
    maxk=frac_c_tot;
else
    maxk=frac_c_tot+frac_c_start-1;
end

for k=frac_c_start:2:(maxk)
   
      L=z(:,:,k);
    
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
      
        r2_bb1=ceil(min(r2_bb1));
        r2_bb2=floor(max(r2_bb2));

        L22=L(:,r2_bb1:r2_bb2,:);
       
    
    
    %Using YFP channel      
      Lp=z(:,:,k);
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
      r_bb2=find(sum_c>0, 1, 'last' );
      L2=L(:,r_bb1:r_bb2,:);
      
      sum_c=sum(Lp2); %using the segmentation mask to find the left boundary
      r_bb1=find(sum_c>0, 1 );
      r_bb2=find(sum_c>0, 1, 'last' );
      
      sum_r=sum(Lp2,2); %using the segmentation mask to find the top boundary
      r_top=find(sum_r>0, 1 )-2; 
      
      if r_top==0
          r_top=1;
      end
     
      if r_top+r_b>size(L,1)
          L2=L(r_top:end,r_bb1:r_bb2,:);
      else
          L2=L(r_top:r_top+r_b,r_bb1:r_bb2,:);
      end
      
      t_e=size(L2,2)+t_b;
        
    tile(1:size(L2,1),1+t_b:t_e,:)=L2;

    t_b=t_e;        
end

tile_r=tile;

imf=imfuse(tile_r,tile_y);

tile_r_n=mat2gray(tile_r);
tile_y_n=mat2gray(tile_y);

%Combined image
imf_n=imfuse(tile_r_n,tile_y_n,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);

figure; imshow(imf_n);
cmap=cmocean('-speed');
colormap(cmap);

map=hsv;