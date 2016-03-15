addpath mmread;
%% Cars
tic;
%* Reading video*
inVideo = mmread('..\data\shakyAffine\shaky_cars.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%* Finding the Affine motion model*
motion = zeros(3,3,totFrames);
motion(:,:,1)=eye(3);

% Using RANSAC
[ des1, loc1] = sift(video(:,:,1));
for i = 2:totFrames
    [ des2, loc2] = sift(video(:,:,i));
    motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'RANSAC' );
    des1=des2; loc1=loc2;
end

% Using Least Square
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'LS' );
%     des1=des2; loc1=loc2;
% end

%* Smoothning and finding the final translation of each frames from its
%stable position*
a= 1:totFrames;
smoothmotion=zeros(size(motion));
motionfinal =zeros(size(motion));
motionfinal(:,:,1)=eye(3);
smoothmotion(3,3,:)=1;
for i=1:2
    for j=1:3
        t=motion(i,j,:);
        t=t(:)';
        s=mySmoothMotion(t);
        smoothmotion(i,j,:)=s;
        figure();plot(a,t,a,s);title(sprintf('A(%d,%d)',i,j));
    end
end


for i = 2:totFrames
    motionfinal(:,:,i)=motion(:,:,i)*pinv(smoothmotion(:,:,i))*motionfinal(:,:,i-1);
    motionfinal(3,:,i)=[0,0,1];
end


% *Forming stablized video*
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    stablized_video(:,:,i) = my_affine_warp(video(:,:,i),pinv(motionfinal(:,:,i)));
end
filename = '..\report\stablizedAffine\stablized_cars_RANSAC.avi';
% filename = '..\report\stablizedAffine\stablized_cars_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;

%% Coastguard
tic;
%* Reading video*
inVideo = mmread('..\data\shakyAffine\shaky_coastguard.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%* Finding the Affine motion model*
motion = zeros(3,3,totFrames);
motion(:,:,1)=eye(3);

% Using RANSAC
[ des1, loc1] = sift(video(:,:,1));
for i = 2:totFrames
    [ des2, loc2] = sift(video(:,:,i));
    motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'RANSAC' );
    des1=des2; loc1=loc2;
end

% Using Least Square
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'LS' );
%     des1=des2; loc1=loc2;
% end

% * Smoothning and finding the final translation of each frames from its
% stable position*
a= 1:totFrames;
smoothmotion=zeros(size(motion));
motionfinal =zeros(size(motion));
motionfinal(:,:,1)=eye(3);
smoothmotion(3,3,:)=1;
for i=1:2
    for j=1:3
        t=motion(i,j,:);
        t=t(:)';
        s=mySmoothMotion(t);
        smoothmotion(i,j,:)=s;
        figure();plot(a,t,a,s);title(sprintf('A(%d,%d)',i,j));
    end
end


for i = 2:totFrames
    motionfinal(:,:,i)=motion(:,:,i)*pinv(smoothmotion(:,:,i))*motionfinal(:,:,i-1);
    motionfinal(3,:,i)=[0,0,1];
end


%* Forming stablized video*
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    stablized_video(:,:,i) = my_affine_warp(video(:,:,i),pinv(motionfinal(:,:,i)));
end
filename = '..\report\stablizedAffine\stablized_coastguard_RANSAC.avi';
% filename = '..\report\stablizedAffine\stablized_coastguard_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;


%% gbus
tic;
%* Reading video*
inVideo = mmread('..\data\shakyAffine\shaky_gbus.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%* Finding the Affine motion model*
motion = zeros(3,3,totFrames);
motion(:,:,1)=eye(3);

% Using RANSAC
[ des1, loc1] = sift(video(:,:,1));
for i = 2:totFrames
    [ des2, loc2] = sift(video(:,:,i));
    motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'RANSAC' );
    des1=des2; loc1=loc2;
end

% Using Least Square
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     motion(:,:,i) = fitAffine(des1, loc1,des2, loc2,'LS' );
%     des1=des2; loc1=loc2;
% end

%* Smoothning and finding the final translation of each frames from its
%stable position*
a= 1:totFrames;
smoothmotion=zeros(size(motion));
motionfinal =zeros(size(motion));
motionfinal(:,:,1)=eye(3);
smoothmotion(3,3,:)=1;
for i=1:2
    for j=1:3
        t=motion(i,j,:);
        t=t(:)';
        s=mySmoothMotion(t);
        smoothmotion(i,j,:)=s;
        figure();plot(a,t,a,s);title(sprintf('A(%d,%d)',i,j));
    end
end


for i = 2:totFrames
    motionfinal(:,:,i)=motion(:,:,i)*pinv(smoothmotion(:,:,i))*motionfinal(:,:,i-1);
    motionfinal(3,:,i)=[0,0,1];
end


% *Forming stablized video*
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    stablized_video(:,:,i) = my_affine_warp(video(:,:,i),pinv(motionfinal(:,:,i)));
end
filename = '..\report\stablizedAffine\stablized_gbus_RANSAC.avi';
% filename = '..\report\stablizedAffine\stablized_gbus_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);

% Motion can be modelled in 3 ways
% fitTranslation -> It will return tx & ty only
% fitTranslation_Rotation -> It will return theta, tx & ty
% fitAffine -> 3x3 matrix

toc;