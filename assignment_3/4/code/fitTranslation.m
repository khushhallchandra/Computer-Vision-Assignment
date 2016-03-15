function [ tx, ty ] = fitTranslation( im1,des1, loc1, im2,des2, loc2, algorithm )
	%   algorithm can be 'RANSAC' or 'LS'

	if strcmp(algorithm, 'RANSAC')
        [p1,p2] = match(des1, loc1,des2, loc2);
	    motion = ransacfithomography(p1',p2',0.005);
        motion = motion./motion(3,3);
        tx=motion(2,3);
        ty=motion(1,3);
	else
	    ijLSE = zeros(21,21);
		im2new = im2; 
		[H,W] = size(im2);
	    for tx=-10:10
		    for ty=-10:10
                %T = [i j];
                %d= p2 - repmat(T,size(p2,1),1)-p1;
%                d= p2 -ones(length(p2),1)*T -p1;
% 				newp1 = p2 - repmat(T,size(p2,1),1);
% 				for k=1:length(p1)
% 					if(newp1(k,1)>0 && newp1(k,1)>0)
%                 		d(k) =  im1(p1(k,1),p1(k,2))- im1(newp1(k,1),newp1(k,2));
% 					else
% 						d(k) = 0;
% 					end
% 				end

				
				im2new(:,:) = 0;
				im2new(max(1,1-ty):min(H-ty,H),max(1,1-tx):min(W-tx,W)) = im2(max(1,1+ty):min(H,H+ty),max(1,1+tx):min(W,W+tx));
				%im2new(max(1,1-ty):min(H-ty,H),max(1,1-tx):min(W-tx,W)) = im2(max(1,1+ty):min(H,H+ty),1+tx:W);
				%d = im2new(1:H-ty,1:W-tx) - im1(1:H-ty,1:W-tx);
	        	%ijLSE(tx+1,ty+1) = sum(sum( d.^2));
				differ = im2new - im1;
				ijLSE(tx+11,ty+11) = sum(sum( differ.^2));
	        end
	    end
		[tx,ty] = find(ijLSE==min(min(ijLSE)));
        tx = tx-11;
        ty = ty-11;
	end
end
