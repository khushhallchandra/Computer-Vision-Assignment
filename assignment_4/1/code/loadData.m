% This function is used for loading dataset
% It takes an input of the form
% partA, partB, partC, partD
function [X_train, Y_train, X_test, Y_test] = loadData(part)
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

		X = normrnd(0, 2, n, 2);
		dist = sqrt(X(:,1).^2 + X(:,2).^2);		
		Y(dist <= 2) = 1;

	elseif(part == 'partD')

		X = normrnd(0, 2, n, 2);
		dist = sqrt(X(:,1).^2 + X(:,2).^2);		
		Y( (dist <= 2) | (dist >= 2.5 & dist <= 3) ) = 1;
	

	elseif(part == 'partE')
		
		[I,labels,~,~] = readMNIST();
		z = I(1,1:5000);
		len = size(z{1},1)*size(z{1},2);
		X_train = zeros([size(z,2) len]);
		for i=1:size(z,2)
			X_train(i,:)=reshape(z{i}',1,len);
		end		
		Y_train = double(labels(1:5000,:));
		check = (Y_train == 2);
		Y_train(~check) = -1;
		Y_train(check) = 1;
		X_test = 0;
		Y_test = 0;
		return
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

