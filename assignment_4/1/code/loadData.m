% This function is used for loading dataset
% It takes an input of the form
% partA, partB, partC, partD
function [X_train,Y_train,X_test,Y_test] = loadData(part)
	n=2000;
	X = rand(n,2);
	Y = -1*ones(n,1);

	if(part == 'partA')

		Y(X(:,1)>=0.3 & X(:,1)<=0.7 & X(:,2)>=0.3 & X(:,2)<=0.7) = 1;

	elseif(part == 'partB')

	    Y(X(:,1)>=0.3 & X(:,1)<=0.7 & X(:,2)>=0.3 & X(:,2)<=0.7) = 1;    
	    Y( (X(:,1)>=0.15 & X(:,1)<=0.25) | (X(:,1)>=0.75 & X(:,1)<=0.85) ) = 1;    
    	Y( (X(:,2)>=0.15 & X(:,2)<=0.25) | (X(:,2)>=0.75 & X(:,2)<=0.85) ) = 1;

	elseif(part == 'partC')
	
		dist = sqrt( X(:,1).^2 + X(:,2).^2);		
		Y(dist <= 2) = 1;

	elseif(part == 'partD')
		
		dist = sqrt(X(:,1).^2 + X(:,2).^2);		
		Y( (dist <= 2) | (distance >= 2.5 & distance <= 3) ) = 1;
	end

    % dividing the data in two parts
   
    split = n/2;
	% series -> to randomly select from the dataset
    series = randperm(n);
    X_train = X(series(1:split), :);
    Y_train = Y(series(1:split));
    X_test = X(series(split+1:end), :);
    Y_test = Y(series(split+1:end));
end

