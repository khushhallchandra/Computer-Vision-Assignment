%% MyMainScript
[X_train, Y_train, X_test, Y_test] = loadData('partA')

epoch = 40;
weight = ones(size(Y))/size(X_train,1);
train_error = zeros(epoch,1);
test_error = zeros(epoch,1);

%(i, p, θ)
i = zeros(epoch,1);
p = zeros(epoch,1);
theta = zeros(epoch,1);
alpha = zeros(epoch,1);

for t = 1:epoch
	%% Choose the best classifier, given current (i, p, θ)

    
    %% Update the weights
    alpha(t) = 0.5 *log((1 - epsilon) / epsilon);

end