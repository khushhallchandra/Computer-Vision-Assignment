function [ jointEnt] = jointEntropy( im1,im2,nBins )
	%size of both the size should be same
	im1=floor((nBins/256)*im1);
	im2=floor((nBins/256)*im2);

	jointHist=zeros(nBins,nBins);

	rows=size(im1,1);
	cols=size(im1,2);

	for i=1:rows
		for j=1:cols
	    	jointHist(im1(i,j)+1,im2(i,j)+1)= jointHist(im1(i,j)+1,im2(i,j)+1)+1;
	    end
	end

	% normalized joint histogram
	J = jointHist./(rows*cols);

	jointEnt = -sum(sum(J.*(log(J+(J==0))))); 

end


