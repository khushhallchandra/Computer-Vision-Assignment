%% MyMainScript1
%This correspond to p1 - 3xn
img1 = importdata('../data/Features2D_dataset1.mat');
p1 = img1(1:2, :)';

%This correspond to p - 4xn
img2 = importdata('../data/Features3D_dataset1.mat');
p = img2(1:3, :)';

n = size(img1, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Adding noise;this may be commented
%maxc = 0.05 * max(max(abs(img2)));
%p1 = p1 + (maxc .* randn([n 2])); 
%p  = p  + (maxc .* randn([n 3]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = [p, ones(n, 1), zeros(n, 4)];
q = -1 * p .* (p1(:, 1)*ones(1,3)) ;
a = [a q (-1 * p1(:, 1))];

b = [zeros(n, 4), p, ones(n, 1)];
r = -1 * p .* ( p1(:, 2)*ones(1,3)) ;
b = [b r (-1 * p1(:, 2))];

A = [ a; b];

[U, D, V] = svd(A);

% Taking the last row of matrix V so
% that we have row of V corresponding
% to min eigen value
m = V(:, 12)';
M = reshape(m, 4, 3)';

p1val = M * img2;
p1val = p1val ./ (ones(3,1)*p1val(3,:));

%% Value of M
M
%% Error between original and calculated image
error = norm(p1val - img1)/sqrt(norm(p1val) * norm(img1)) * 100;
% value of e (in percentage)
error