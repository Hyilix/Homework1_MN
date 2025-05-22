function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  % Theta -> the vector of weights
  % Y -> the vector with all actual values
  % FeatureMatrix -> the matrix with all training examples

  % Error -> the error of the regularized cost function

  m = length(Y);

  % reduce Theta (first element is 0 anyway)
  Theta = Theta(2 : end);

  predictions = FeatureMatrix * Theta;
  dif = predictions - Y;

  % get error
  Error = (1 / (2 * m)) * sum(dif .^ 2);
end
