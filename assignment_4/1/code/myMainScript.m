tic;
%% Load Dataset
[X_train, Y_train, X_test, Y_test] = loadData('partE');

%%Plot the data
%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% plus = X_train(Y_train == 1,:);
% minus = X_train(Y_train == -1,:);
% scatter(plus(:,1),plus(:,2),'b')
% hold on
% scatter(minus(:,1),minus(:,2),'r')
% legend('+1','-1')
% title('Plot of training data');
%%%%%%%%%%%%%%%%%%%%%%%%%%%

epoch = 40;
%(i, p, theta)
i = zeros(epoch,1);
p = zeros(epoch,1);
theta = zeros(epoch,1);
alpha = zeros(epoch,1);
weight = ones(size(Y_train))/size(Y_train,1);

for t = 1:epoch
    %% Find best classifier with current weights
    epsilon = 1;
    for j = 1:size(X_train,2)
        c = unique(X_train(:,j));
        for k =1:length(c)		
            th = c(k);
%         for k =1:size(X_train,1)
%             th = X_train(k,j);
			% Counting the number of mismatches
            error = sum(weight.*( Y_train ~= sign( (X_train(:,j) - th) + ~logical(X_train(:,j) - th)) ));
            pTest = 1;
            if error > 0.5
                error = 1 - error;
                pTest = -1;
            end
            
            if error < epsilon
                epsilon = error;
                i(t) = j;
                theta(t) = th;
                p(t) = pTest;
            end
        end
    end
    % Updating the weights
    alpha(t) = 0.5*log((1-epsilon)/epsilon);
    label = (Y_train ~= sign(p(t)*(X_train(:,i(t)) - theta(t))));    
    weight(label) = weight(label)*exp(alpha(t));
    weight(~label) = weight(~label)*exp(-alpha(t));    
    weight = weight/sum(weight);

	%% Calculating the errors
	
	% estimate and print the training error 
	% of the strong classifier created thus far  
	t 
	Y_train_predicted = zeros(size(Y_train));
	for k = 1:t
		Y_train_predicted = Y_train_predicted+ alpha(k)*sign(p(k)*(X_train(:,i(k)) - theta(k)));
	end
	Y_train_predicted = sign(Y_train_predicted);
	train_error = sum(Y_train~=Y_train_predicted)*100/length(Y_train) 

	% estimate and print the test error of 
	% the strong classifier created thus far 
% 	Y_strong_test = zeros(size(Y_test));
% 	for k = 1:t
% 		Y_strong_test = Y_strong_test+ alpha(k)*sign(p(k)*(X_test(:,i(k)) - theta(k)));
% 	end
% 	Y_strong_test = sign(Y_strong_test);
% 	test_error = sum(Y_test~=Y_strong_test)*100/length(Y_test)
end
toc;
