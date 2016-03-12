tic;
addpath mmread;
%addpath codedata;
%% Read videao
inVideo = mmread('..\data\shakyRigid\shaky_cars.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%% Finding the Rigid motion model
motion = zeros(3,3,totFrames);

% Using RANSAC
[ des1, loc1] = sift(video(:,:,1));
for i = 2:25
    [ des2, loc2] = sift(video(:,:,i));
    motion(:,:,i) = fitTranslation_Rotation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
    des1=des2; loc1=loc2;
end

% Using Least Square
% for i = 2:totFrames
%     motion = fitTranslation_Rotation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
% end
% Note: motion is 3x3xn-1 matrix it contain theta and translation.
% be careful here. no need to acos asin here

%% Smoothning and finding the final translation of each frames from its stable position
% a=[1:251];
tx = motion(2,3,:); tx=tx(:)';
ty = motion(1,3,:); ty=ty(:)';
theta = (motion(2,1,:))*180/pi; theta=theta(:)';
smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);

smoothTheta = mySmoothMotion(theta);

txfinal=tx;
tyfinal=ty;
thetafinal=theta;
txfinal(:)=0;tyfinal(:)=0;thetafinal(:)=0;
for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
	thetafinal(i)=theta(i)-smoothTheta(i)+thetafinal(i-1);
end

txfinal=round(txfinal);tyfinal=round(tyfinal);
txfinal=(txfinal+abs(txfinal))/2;tyfinal=(tyfinal+abs(tyfinal))/2;
%figure();plot(e-txfinal);


%% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
%     d = video(:,:,i); d(:,:) = 0;
%     d(1:H-tyfinal(i),1:W-txfinal(i)) = video(1+tyfinal(i):H,1+txfinal(i):W,i);    
    stablized_video(:,:,i) = imrotate(video(:,:,i),-thetafinal(i),'bilinear','crop');
end
filename = '..\report\shakyRigid\shaky_cars_RANSAC.avi';
%filename = '..\report\shakyRigid\shaky_cars_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);

% 
% [ des1, loc1] = sift(video(:,:,2));
% [ des2, loc2] = sift(video(:,:,3));
% [x1,x2] = match(des1, loc1,des2, loc2);
% x1=x1';x2=x2';
% npts=length(x1);
% x1 = [x1; ones(1,npts)];
% x2 = [x2; ones(1,npts)]; 
% A=x2*x1'/(x1*x1');

