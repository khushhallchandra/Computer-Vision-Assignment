%% MyMainScript2
flash = imread('../data/barbara.png');
flash = rgb2gray(flash);

noflash = imread('../data/negative_barbara.png');
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
