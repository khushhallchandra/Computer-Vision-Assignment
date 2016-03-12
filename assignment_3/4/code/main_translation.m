tic;
addpath mmread;
%addpath codedata;
%% Reading videao
inVideo = mmread('..\data\shakyTranslation\shaky_cars.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%% Finding the translational motion model
tx = zeros(1,totFrames);
ty = zeros(1,totFrames);

% Using RANSAC
[ des1, loc1] = sift(video(:,:,1));
for i = 2:25
    [ des2, loc2] = sift(video(:,:,i));
    [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'LS' );
    des1=des2; loc1=loc2;
end

% Using Least Square
% for i = 2:totFrames
%     [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
% end

%% Smoothning and finding the final translation of each frames from its stable position
% a=[1:251];
smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
%plot(a,tx,a,smoothtx);
txfinal=tx;tyfinal=ty;
txfinal(:)=0;tyfinal(:)=0;
for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
end
%figure();plot(a,txfinal,a,e);
txfinal=round(txfinal);tyfinal=round(tyfinal);
txfinal=(txfinal+abs(txfinal))/2;tyfinal=(tyfinal+abs(tyfinal))/2;
%figure();plot(e-txfinal);


%% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(1:H-tyfinal(i),1:W-txfinal(i)) = video(1+tyfinal(i):H,1+txfinal(i):W,i);
    stablized_video(:,:,i) = d;
end
filename = '..\report\shakyTranslation\shaky_cars_RANSAC.avi';
%filename = '..\report\shakyTranslation\shaky_cars_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
% Motion can be modelled in 3 ways
% fitTranslation -> It will return tx & ty only
% fitTranslation_Rotation -> It will return theta, tx & ty
% fitAffine -> 3x3 matrix

% Note :- motion vector in all the three case will 3x3x(totFrames-1)
% Therefor use accordingly for further use. 
% ex - tx and ty will be at (1,3) & (2,3) respectively
% ex - theta, tx, ty will be at (1,1), (1,3) & (2,3) respectively

%% smooth the motion sequence using a simple averaging filter
toc;