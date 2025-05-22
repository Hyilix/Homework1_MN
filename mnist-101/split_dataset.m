function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  % X -> the loaded dataset with all training examples
  % y -> the corresponding labels
  % percent -> fraction of training examples to be put in training dataset

  % X_[train|test] -> the datasets for training and test respectively
  % y_[train|test] -> the corresponding labels

  % Example: [X, y] has 1000 training examples with labels and percent = 0.85
  %           -> X_train will have 850 examples
  %           -> X_test will have the other 150 examples

  m = size(X)(1);

  perm = randperm(m);

  m_train = round(percent * m);

  train = perm(1 : m_train);
  test = perm(m_train + 1 : end);

  X_train = X(train, :);
  y_train = y(train, :);
  X_test = X(test, :);
  y_test = y(test, :);
end
