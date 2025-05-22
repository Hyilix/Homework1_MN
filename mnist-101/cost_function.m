function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)

  % params -> vector containing the weights from the two matrices
  %           Theta1 and Theta2 in an unrolled form (as a column vector)
  % X -> the feature matrix containing the training examples
  % y -> a vector containing the labels (from 1 to 10) for each
  %      training example
  % lambda -> the regularization constant/parameter
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % J -> the cost function for the current parameters
  % grad -> a column vector with the same length as params
  % These will be used for optimization using fmincg

  m = size(X, 1);

  % Get Theta1 and Theta2

  Theta1 = reshape(params(1 : hidden_layer_size * (input_layer_size + 1)),...
                    hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(params((1 + hidden_layer_size * (input_layer_size + 1)) : end),...
                  output_layer_size, (hidden_layer_size + 1));

  J = 0;
  Theta1_g = zeros(size(Theta1));
  Theta2_g = zeros(size(Theta2));

  % Forward propagation

  a1 = [ones(m, 1) X];
  z2 = a1 * Theta1';
  a2 = sigmoid(z2);
  a2 = [ones(m, 1) a2];
  z3 = a2 * Theta2';
  a3 = sigmoid(z3);

  % Get cost

  y_mat = eye(output_layer_size)(y , :);

  cost = -y_mat .* log(a3) - (1 - y_mat) .* log(1 - a3);
  J = (1 / m) * sum(cost(:));

  lan = (lambda / (2 * m)) * (sum(sum(Theta1(:, 2 : end) .^ 2)) +...
        sum(sum(Theta2(:, 2 : end) .^ 2)));
  J = J + lan;

  delta3 = a3 - y_mat;
  delta2 = (delta3 * Theta2) .* [ones(size(z2, 1), 1) (sigmoid(z2) .* (1 - sigmoid(z2)))];
  delta2 = delta2(:, 2 : end);  % remove bias

  % Acumulation of gradients
  Delta1 = delta2' * a1;
  Delta2 = delta3' * a2;

  Theta1_g = (1/m) * Delta1;
  Theta2_g = (1/m) * Delta2;

  Theta1_g(:,2:end) += (lambda / m) * Theta1(:,2:end);
  Theta2_g(:,2:end) += (lambda / m) * Theta2(:,2:end);

  % unrolling
  grad = [Theta1_g(:) ; Theta2_g(:)];

end
