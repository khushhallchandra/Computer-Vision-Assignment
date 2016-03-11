clear;
addpath mmread;
%% Read videao
inVideo = mmread('..\data\sampleVideo\shakyAffine\cars.avi');
totFrames = inVideo.nrFramesTotal;
video = zeros(inVideo.height, inVideo.width, totFrames);
% cdata       [height X width X 3] uint8 matricies
for i  = 1:totFrames
    video(:,:,i) = inVideo.frames(i).cdata(:,:,1);
end

%% Finding the motion model
motion = zeros(3,3,totFrames-1);
for i = 1:totFrames-1
    motion(:,:,i) = fitTranslation(video(:,:i),video(:,:i+1),'RANSAC' );
end

% Motion can be modelled in 3 ways
% fitTranslation -> It will return tx & ty only
% fitTranslation_Rotation -> It will return theta, tx & ty
% fitAffine -> 3x3 matrix

% Note :- motion vector in all the three case will 3x3x(totFrames-1)
% Therefor use accordingly for further use. 
% ex - tx and ty will be at (1,3) & (2,3) respectively
% ex - theta, tx, ty will be at (1,1), (1,3) & (2,3) respectively

%% smooth the motion sequence using a simple averaging filter
