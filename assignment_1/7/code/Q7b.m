%% Q7b

img1 = imread('../data/goi1_downsampled.jpg');
img2 = imread('../data/goi2_downsampled.jpg');

[p1 , p2] =match(img1,img2);

%  we have now physically corresponding points p1 and p2
n= length(p1(:,1));
a = [-1*p1, -1*ones(n,1), zeros(n, 3)];
a = [a (p2(:,1)*ones(1,2)).*p1  p2(:,1)];

b = [zeros(n, 3), -1*p1, -1*ones(n, 1) (p2(:,2)*ones(1,2)).*p1 p2(:,2)];

A = [ a; b];

[U ,  D , V ] = svd(A);

% Taking the last row of matrix V so that we have row of V 
% corresponding to min eigen value
m = V(:, 9)';
M = reshape(m, 3, 3)';
M=M./M(3,3);

img1New = myRevWrap(img1, M);
subplot(1,3,1);imshow(img1);
subplot(1,3,2);imshow(img2);
subplot(1,3,3);imshow(img1New);

% printing Homographic matrix
M 
