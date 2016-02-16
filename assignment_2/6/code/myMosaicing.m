function out = myMosaicing(img1,img2,H)

	[ x1 ,y1 ] = size(img1);
    [ x2 ,y2 ] = size(img2);
% 	x_vec = repmat(1 x1, 2,1);
% 	y_vec = repmat(1 y1, 1, 2);

	imgT = [ 1 1 x1 x1 ; 1 y1 1 y1 ; ones(1,4) ];
	im = H*imgT;
	im = round(im ./ (ones(3,1)*im(3,:)));
	im = im(1:2, :);
    p=min(min(im(1,:)),1);
    q=max(max(im(1,:)),x2);
    r=min(min(im(2,:)),1);
    s=max(max(im(2,:)),y2);
    
    out=zeros(q-p+1,s-r+1);
    out(2-p:(1-p+x2),2-r:(1-r+y2))=img2;
    
    x_vec = repmat(1:(q-p+1), (s-r+1),1)+p-1;
	y_vec = repmat(1:(s-r+1), 1, (q-p+1))+r-1;

	imgT = [ x_vec(:)' ; y_vec ; ones(1,(q-p+1)*(s-r+1)) ];
    im = H\imgT;
	im = round(im ./ (ones(3,1)*im(3,:)));
	im = im(1:2, :);
    
    for i = 1 : (q-p+1)*(s-r+1)
	    if (~(imgT(1,i)>1 && imgT(1,i)<x2 && imgT(2,i)>1 && imgT(2,i)<y2) && im(1,i)>1 && im(1,i)<x1 && im(2,i)>1 && im(2,i)<y1)
            out(imgT(1,i)-p+1,imgT(2,i)-r+1)=img1(im(1,i),im(2,i));    
	    end
    end
    
% 	for i = 1 : x1*y1
%         out(im(1,i)-p+1,im(2,i)-r+1)=img1(imgT(1,i),imgT(2,i));
%   end
    out = uint8(out);
end
