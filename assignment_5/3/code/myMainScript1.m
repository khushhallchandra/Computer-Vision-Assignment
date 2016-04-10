%% Reconstruction using OMP
tic;
img = imread('../data/barbara256.png');
[x,y] = size(img);
pSize = 8;
% The patches are created by sliding the 8X8 window over 
% the image shifting 1 unit each time either in x or y
patches = zeros(pSize*pSize,(x-pSize+1)*(y-pSize+1));
i = 0;
for row = 1:y-pSize+1
	for col = 1:x-pSize+1
		i = i + 1;
		patch = img(col:col+pSize-1,row:row+pSize-1);
		patches(:,i) = patch(:);
	end
end

n = 64;
phi = randn(n,n);
f = [0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05];
M = ceil(f*n);
for m = M
	% Submatrix consisting of the first m rows
	phiM = phi(1:m,:);
	X = patches;
	Y = phiM * X;
	sd = 0.05 * mean(abs(Y(:)));
	% Added noise to Y    
	Y = Y + sd * randn(size(Y));
	% DCT matrix
	U = kron(dctmtx(pSize)',dctmtx(pSize)');
	A = phiM * U;

	%estimate = omp(Y, A, sd);


end
toc;