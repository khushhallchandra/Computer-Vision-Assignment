function out = my_affine_warp(img,H)
    
	[ x ,y ] = size(img);
	x_vec = repmat(1:x, y,1);
	y_vec = repmat(1:y, 1, x);

	imgT = [ x_vec(:)' ; y_vec ; ones(1,x*y) ];
	im = H\imgT;
	im = round(im ./ (ones(3,1)*im(3,:)));
	im = im(1:2, :);

	v = zeros(x*y,1);
	for i = 1 : x*y
	    if ((im(1,i)<1 || im(1,i)>x) || (im(2,i)<1 || im(2,i)>y))
		v(i) =0; 
	    else
		v(i)=img(im(1,i),im(2,i));
	    end
	end
	out = uint8(reshape(v,y,x)');
end
