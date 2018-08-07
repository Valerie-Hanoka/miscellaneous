function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% Generating all possible parameters C and sigma
test_param_values = [0.01, 0.03, 0.1, 0.3, 1.0, 3.0, 10.0, 30.0];
[tx ty] = ndgrid (test_param_values);
Perm = [tx(:) ty(:)];
trials = size(Perm, 1);
pred_errors = ones(trials, 1);

% running trials on all permutations of parameters
%test_param_str = sprintf('%d ', test_param_values);
%fprintf(['Running tests for C and sigma values in  [ %s] (%i tests)\n'], test_param_str, trials);
for trial=1:trials
    model= svmTrain(X, y, Perm(trial, 1), @(x1, x2) gaussianKernel(x1, x2, Perm(trial, 2)));
    prediction = svmPredict(model, Xval);
    pred_errors(trial) = mean(double(prediction ~= yval));
end

% finding and returning the best C and sigma
[min_err, min_id] = min(pred_errors);
best_params = Perm(min_id, :);
C = best_params(1);
sigma = best_params(2);
%fprintf(['Best parameters found for C=%f and sigma=%f\n'], C, sigma);

% =========================================================================

end
