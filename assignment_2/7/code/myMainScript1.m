%% MyMainScript1
flash = imread('../data/flash.jpg');
flash = rgb2gray(flash);

noflash = imread('../data/noflash.jpg');
noflash = rgb2gray(noflash);

%applying transformations
noflash = imrotate(noflash, 28.5);
noflash = imtranslate(noflash, [-2,0]);
noflash = double(noflash) + 10.*(randn(size(noflash))); 
noflash(noflash<0) = 0;
noflash(noflash>255) = 255;

for theta = -60:60
    for tx = -12:12

    end

end
        
