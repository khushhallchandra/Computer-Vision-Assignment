addpath mmread;
%% Cars
tic;
%* Reading video*
inVideo = mmread('..\data\shakyTranslation\shaky_cars.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the translational motion model
tx = zeros(1,totFrames);
ty = zeros(1,totFrames);

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end

% Smoothning and finding the final translation of each frames from its stable position
a= 1:totFrames;
smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');

txfinal=tx;tyfinal=ty;
txfinal(:)=0;tyfinal(:)=0;
for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
end
txfinal=round(txfinal);tyfinal=round(tyfinal);


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);
    stablized_video(:,:,i) = d;
end
% filename = '..\report\stablizedTranslation\stablized_cars_RANSAC.avi';
filename = '..\report\stablizedTranslation\stablized_cars_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;

%% Coastguard
tic;
%* Reading video*
inVideo = mmread('..\data\shakyTranslation\shaky_coastguard.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the translational motion model
tx = zeros(1,totFrames);
ty = zeros(1,totFrames);

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end

% Smoothning and finding the final translation of each frames from its stable position
a= 1:totFrames;
smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');

txfinal=tx;tyfinal=ty;
txfinal(:)=0;tyfinal(:)=0;
for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
end
txfinal=round(txfinal);tyfinal=round(tyfinal);


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);
    stablized_video(:,:,i) = d;
end
% filename = '..\report\stablizedTranslation\stablized_coastguard_RANSAC.avi';
filename = '..\report\stablizedTranslation\stablized_coastguard_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;

%% gbus
tic;
%* Reading video*
inVideo = mmread('..\data\shakyTranslation\shaky_gbus.avi');
totFrames = inVideo.nrFramesTotal;
framerate = inVideo.rate;
video = zeros(inVideo.height, inVideo.width, totFrames);
stablized_video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

% Finding the translational motion model
tx = zeros(1,totFrames);
ty = zeros(1,totFrames);

% Using RANSAC
% [ des1, loc1] = sift(video(:,:,1));
% for i = 2:totFrames
%     [ des2, loc2] = sift(video(:,:,i));
%     [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),des1, loc1,video(:,:,i),des2, loc2,'RANSAC' );
%     des1=des2; loc1=loc2;
% end

% Using Least Square
for i = 2:totFrames
    [tx(i),ty(i)] = fitTranslation(video(:,:,i-1),0, 0,video(:,:,i),0, 0,'LS' );
end

% Smoothning and finding the final translation of each frames from its stable position
a= 1:totFrames;
smoothtx=mySmoothMotion(tx);
smoothty=mySmoothMotion(ty);
plot(a,tx,a,smoothtx);title('tx');
figure();plot(a,ty,a,smoothty);title('ty');

txfinal=tx;tyfinal=ty;
txfinal(:)=0;tyfinal(:)=0;
for i = 2:totFrames
    txfinal(i)=tx(i)-smoothtx(i)+txfinal(i-1);
    tyfinal(i)=ty(i)-smoothty(i)+tyfinal(i-1);
end
txfinal=round(txfinal);tyfinal=round(tyfinal);


% Forming stablized video
[H,W]=size(video(:,:,1));
for i  = 1:totFrames
    d = video(:,:,i); d(:,:) = 0;
    d(max(1,1-tyfinal(i)):min(H-tyfinal(i),H),max(1,1-txfinal(i)):min(W-txfinal(i),W)) = ...
    video(max(1,1+tyfinal(i)):min(H,H+tyfinal(i)),max(1,1+txfinal(i)):min(W,W+txfinal(i)),i);
    stablized_video(:,:,i) = d;
end
%filename = '..\report\stablizedTranslation\stablized_gbus_RANSAC.avi';
filename = '..\report\stablizedTranslation\stablized_gbus_LS.avi';
bothvideo = zeros(inVideo.height, 2*inVideo.width, totFrames);
bothvideo(:,1:W,:)=video(:,:,:);
bothvideo(:,W+1:2*W,:)=stablized_video(:,:,:);
writevideo(filename,bothvideo/max(bothvideo(:)),framerate);
toc;
% Motion can be modelled in 3 ways
% fitTranslation -> It will return tx & ty only
% fitTranslation_Rotation -> It will return theta, tx & ty
% fitAffine -> 3x3 matrix

toc;