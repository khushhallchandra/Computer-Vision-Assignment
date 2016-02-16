function [out ] = imtranslate(img,tx)
	out = zeros(size(img));
    y = size(img,2);
    if(tx > 0)    
        out( : , tx+1 : y ) = img( : , 1 : y - tx);
    else
        out( : , 1: tx + y) = img( : , 1 - tx : y); 
    end
end



