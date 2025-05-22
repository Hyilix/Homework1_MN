function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % n -> the number of predictors
  % m -> the number of trainings
  % alpha -> the learning rate
  % iter -> the number of iterations

  % Theta -> the vector of weights

  % initial aproximation
  Theta = zeros(n + 1, 1);

  for i = 1 : iter
    predictions = FeatureMatrix * Theta(2 : end);
    dif = predictions - Y;
    gradient = (1 / m) * (FeatureMatrix' * dif);
    Theta(2 : end) = Theta(2 : end) - alpha * gradient;
  end

end
