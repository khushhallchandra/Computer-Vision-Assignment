%% Q6
tic;
%% tajnew
img1 = imread('../data/tajnew1_downsampled.jpg');
img2 = imread('../data/tajnew2_downsampled.jpg');

img1=img1(:,:,1);
img2=img2(:,:,1);
[p1 , p2] =match(img1,img2);

%  we have now physically corresponding points p1 and p2
[M, inliers]=ransacfithomography(p1',p2',0.005);

M=M./M(3,3);
img1New = myMosaicing(img1,img2,M);
figure();
subplot(1,7,1:2);imshow(img1);
subplot(1,7,3:4);imshow(img2);
subplot(1,7,5:7);imshow(img1New);

%% tajold
img1 = imread('../data/tajold1_downsampled.jpg');
img2 = imread('../data/tajold2_downsampled.jpg');

img1=img1(:,:,1);
img2=img2(:,:,1);
[p1 , p2] =match(img1,img2);

%  we have now physically corresponding points p1 and p2
[M, inliers]=ransacfithomography(p1',p2',0.005);

M=M./M(3,3);
img1New = myMosaicing(img1,img2,M);
figure();
subplot(1,7,1:2);imshow(img1);
subplot(1,7,3:4);imshow(img2);
subplot(1,7,5:7);imshow(img1New);

%% Hostel-6
img1 = imread('../data/Hostel61.jpg');
img2 = imread('../data/Hostel62.jpg');

img1=img1(:,:,1);
img2=img2(:,:,1);
[p1 , p2] =match(img1,img2);

%  we have now physically corresponding points p1 and p2
[M, inliers]=ransacfithomography(p1',p2',0.005);

M=M./M(3,3);
img1New = myMosaicing(img1,img2,M);
figure();
subplot(1,4,1);imshow(img1);
subplot(1,4,2);imshow(img2);
subplot(1,4,3:4);imshow(img1New);

toc;
