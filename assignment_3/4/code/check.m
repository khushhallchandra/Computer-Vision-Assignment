img1=video(:,:,2);
[H,W]=size(video(:,:,1));
theta=5;tx=4;ty=2;

d = img1; d(:,:) = 0;
d(ty+1:H,tx+1:W) = img1(1:H-ty,1:W-tx);
c = imrotate(d,theta,'bilinear','crop');    
img2=c;

[ des1, loc1] = sift(img1);
[ des2, loc2] = sift(img2);
[x1,x2] = match(des1, loc1,des2, loc2);
%x1=x1';x2=x2';
% centroid_x1 = mean(x1);
% centroid_x2 = mean(x2);
% 
% N = size(x1,1);
% 
% H = (x1 - repmat(centroid_x1, N, 1))' * (x2 - repmat(centroid_x2, N, 1));
% 
% [U,~,V] = svd(H);
% 
% R = V*U';
% 
% if det(R) < 0
%     %printf("Reflection detected\n");
%     V(:,3) = -V(:,3);
%     R = V*U';
% end
% 
% t = -R*centroid_x1' + centroid_x2';
[H, inliers] = ransacfitrigid(x1', x2', 0.005);
H=H/H(3,3);
thetanew=asin(H(2,1))*180/pi;
txnew=H(2,3);tynew=H(1,3);