function  motion = fitAffine( des1, loc1, des2, loc2, algorithm )
	%   algorithm can be 'RANSAC' or 'LS'
    [p1,p2] = match(des1, loc1,des2, loc2);
	if strcmp(algorithm, 'RANSAC')
      
	    motion = ransacfitaffine(p1',p2',0.01);
    else
        x1=[p1,ones(length(p1),1)];
        x2=[p2,ones(length(p2),1)];
        motion=(pinv(x1)*x2)';
	end

	motion = motion./motion(3,3);

end
