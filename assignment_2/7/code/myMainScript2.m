%% MyMainScript2
flash = imread('../data/barbara.png');

noflash = imread('../data/negative_barbara.png');

%applying transformations
noflash = imrotate(noflash, 28.5, 'nearest', 'crop');
%Do translation here, it is wrapping the image
% There is already a function in Matlab
%noflash = imtranslate(noflash, [-2,0]);
noflash = imtranslate(noflash, -2,0);
noflash = double(noflash) + 10.*(randn(size(noflash))); 
noflash(noflash<0) = 0;
noflash(noflash>255) = 255;

nBins = 10;
ijEnt = zeros(121,25);

for theta = -60:60
    for tx = -12:12
        im = imrotate(noflash, theta, 'nearest', 'crop');
        im = imtranslate(im,tx,0);
	%this is for safety, if values go out of range
	im(im<0) = 0;
        im(im>255) =255;        
        ijEnt(theta+61,tx+13)=jointEntropy(flash,uint8(im),nBins);
    end
end   

[X,Y]=meshgrid(-60:1:60,-12:1:12);
surf(X,Y,ijEnt'); 
[ang,t]=find(ijEnt==min(min(ijEnt)));

finalIm=imrotate(imtranslate(noflash,t-13),t-61,'nearest','crop');
figure 1,imshow(flash)
figure 2,imshow(uint8(noflash))
figure 3,imshow(uint8(finalIm))
