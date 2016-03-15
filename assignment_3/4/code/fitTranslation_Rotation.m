function [tx,ty,theta] = fitTranslation_Rotation( im1,des1, loc1,im2,des2, loc2 , algorithm )
	%   algo can be 'RANSAC' or 'LS'	

	if strcmp(algorithm, 'RANSAC')
        [p1,p2] = match(des1, loc1,des2, loc2);
        motion = ransacfitrigid(p1',p2',0.1);
        theta = asin(motion(2,1))*180/pi;
        tx = motion(2,3);
        ty = motion(1,3);
	
	else
	    im2new = im2; 
        [H,W] = size(im2);
        minimum=10000000000;
        for theta=-6:6
            im3 = imrotate(im2,-theta,'bilinear','crop');
            for tx=-10:10
                for ty=-10:10
                    im2new(:,:) = 0;
                    im2new(max(1,1-ty):min(H-ty,H),max(1,1-tx):min(W-tx,W)) = im3(max(1,1+ty):min(H,H+ty),max(1,1+tx):min(W,W+tx));

                    differ = im2new - im1;
                    a = sum(sum( differ.^2));
                    if(minimum>a)
                        minimum=a;
                        x=tx;y=ty;z=theta;
                    end
                end
            end
        end
        tx=x;
        ty=y;
        theta=z;
	end
end
