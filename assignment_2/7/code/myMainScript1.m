%% MyMainScript1
flash = imread('../data/flash.jpg');
flash = double(rgb2gray(flash));
%flash = flash(1:3:end,1:3:end);

noflash = imread('../data/noflash.jpg');
noflash = double(rgb2gray(noflash));
%noflash = noflash(1:3:end,1:3:end);

%applying transformations
noflash = double(imrotate(noflash, 28.5, 'nearest', 'crop'));
noflash = imtranslate(noflash, -2);

noflash = noflash  + 10.*(randn(size(noflash))); 
noflash(noflash<0) = 0;
noflash(noflash>255) = 255;

nBins = 10;
ijEnt = zeros(61,25);

for theta = -30:30
    for tx = -12:12
        im = imtranslate(noflash,tx);
        im = imrotate(im, theta, 'nearest', 'crop');
        ijEnt(theta+31,tx+13)=jointEntropy(uint8(flash),uint8(im),nBins);
    end
end   

[X,Y]=meshgrid(-30:1:30,-12:1:12);
surf(X,Y,ijEnt');
[ang,t]=find(ijEnt==min(min(ijEnt)));

finalIm=imrotate(imtranslate(noflash,t-13),ang-31,'nearest','crop');
figure ,imshow(uint8(flash))
title('original flash image')
figure ,imshow(uint8(noflash))
title('transformed noflash image')
figure ,imshow(uint8(finalIm))
title('final noflash image')
