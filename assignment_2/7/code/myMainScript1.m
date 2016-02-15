%% MyMainScript1
flash = double(imread('../data/flash.jpg'));
flash = rgb2gray(flash);
%flash = flash(1:2:end,1:2:end);

noflash = double(imread('../data/noflash.jpg'));
noflash = rgb2gray(noflash);
%noflash = noflash(1:2:end,1:2:end);

%applying transformations
noflash = imrotate(noflash, 28.5, 'nearest', 'crop');
%Do translation here, it is wrapping the image
% There is already a function in Matlab
noflash = imtranslate(noflash, -2);
% noflash = imtranslate(noflash, -2,0);
noflash = noflash + 10.*(randn(size(noflash))); 
noflash(noflash<0) = 0;
noflash(noflash>255) = 255;

nBins = 10;
ijEnt = zeros(121,25);

for theta = -60:60
    for tx = -12:12
        im = imrotate(noflash, theta, 'nearest', 'crop');
        im = imtranslate(im,tx);
	%this is for safety, if values go out of range
        im(im<0) = 0;
        im(im>255) =255;
        
        ijEnt(theta+61,tx+13)=jointEntropy(flash,im,nBins);

    end
end   

[X,Y]=meshgrid(-60:1:60,-12:1:12);
surf(X,Y,ijEnt');
[ang,t]=find(ijEnt==min(min(ijEnt)));

finalIm=imrotate(imtranslate(noflash,t-13),ang-61,'nearest','crop');
figure ,imshow(uint8(flash))
figure ,imshow(uint8(noflash))
figure ,imshow(uint8(finalIm))
