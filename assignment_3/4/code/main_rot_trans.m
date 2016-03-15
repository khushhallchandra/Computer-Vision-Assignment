addpath mmread;
%% Cars
tic;
% Read video
inVideo = mmread('..\data\shakyRigid\shaky_cars.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the Rigid motion model
tx = zeros(1,totFrames);
ty = tx;
theta =tx;

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end
% Note: motion is 3x3xn-1 matrix it contain theta and translation.
% be careful here. no need to acos asin here

% Smoothning and finding the final rigid tranformation of each frames from its stable position
a= 1:totFrames;

smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
smoothTheta = mySmoothMotion(theta);
figure();plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');
figure();plot(a,theta,a,smoothTheta);title('theta');

txfinal=tx;
txfinal(:)=0;tyfinal=txfinal;thetafinal=txfinal;

for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
	thetafinal(i)=theta(i)-smoothTheta(i)+thetafinal(i-1);
end

txfinal=round(txfinal);tyfinal=round(tyfinal);
%txfinal(:)=0;tyfinal(:)=0;


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);    
    stablized_video(:,:,i) = imrotate(d,-thetafinal(i),'bilinear','crop');
end

% filename = '..\report\stablizedRigid\stablized_cars_RANSAC.avi';
filename = '..\report\stablizedRigid\stablized_cars_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;

%% Coastguard
tic;
% Read video
inVideo = mmread('..\data\shakyRigid\shaky_coastguard.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the Rigid motion model
tx = zeros(1,totFrames);
ty = tx;
theta =tx;

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end
% Note: motion is 3x3xn-1 matrix it contain theta and translation.
% be careful here. no need to acos asin here

% Smoothning and finding the final rigid tranformation of each frames from its stable position
a= 1:totFrames;

smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
smoothTheta = mySmoothMotion(theta);
figure();plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');
figure();plot(a,theta,a,smoothTheta);title('theta');

txfinal=tx;
txfinal(:)=0;tyfinal=txfinal;thetafinal=txfinal;

for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
	thetafinal(i)=theta(i)-smoothTheta(i)+thetafinal(i-1);
end

txfinal=round(txfinal);tyfinal=round(tyfinal);
% txfinal(:)=0;tyfinal(:)=0;


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);  

    stablized_video(:,:,i) = imrotate(d,-thetafinal(i),'bilinear','crop');
end

% filename = '..\report\stablizedRigid\stablized_coastguard_RANSAC.avi';
filename = '..\report\stablizedRigid\stablized_coastguard_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;

%% gbus
tic;
% Read video
inVideo = mmread('..\data\shakyRigid\shaky_gbus.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the Rigid motion model
tx = zeros(1,totFrames);
ty = tx;
theta =tx;

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i),theta(i)] = fitTranslation_Rotation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end
% Note: motion is 3x3xn-1 matrix it contain theta and translation.
% be careful here. no need to acos asin here

% Smoothning and finding the final rigid tranformation of each frames from its stable position
a= 1:totFrames;

smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
smoothTheta = mySmoothMotion(theta);
figure();plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');
figure();plot(a,theta,a,smoothTheta);title('theta');

txfinal=tx;
txfinal(:)=0;tyfinal=txfinal;thetafinal=txfinal;

for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
	thetafinal(i)=theta(i)-smoothTheta(i)+thetafinal(i-1);
end

txfinal=round(txfinal);tyfinal=round(tyfinal);
% txfinal(:)=0;tyfinal(:)=0;


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);    
    stablized_video(:,:,i) = imrotate(d,-thetafinal(i),'bilinear','crop');
end

% filename = '..\report\stablizedRigid\stablized_gbus_RANSAC.avi';
filename = '..\report\stablizedRigid\stablized_gbus_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;
