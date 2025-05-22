function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
  % FeatureMatrix -> the matrix with all training examples
  % Y -> the vector with all actual values
  % tol -> the learning rate
  % iter -> the number of iterations
  % tol -> the tolerance level for convergence of the conjugate gradient method

  % Theta -> the vector of weights

  [m n] = size(FeatureMatrix);

  A = FeatureMatrix' * FeatureMatrix;
  b = FeatureMatrix' * Y;

  Theta = zeros(n + 1, 1);

  % check eigenvalues for pozitive definite
  if !all(eig(A) > 0)
    return;
  end

  % Conjugate Gradient Method
  r = b - A * Theta(2 : end);
  v = r;

  tol_sq = tol ^ 2;
  r_old = r' * r;

  k = 1;

  while k <= iter && r_old > tol_sq
    t = (r_old) / (v' * A * v);

    Theta(2 : end) = Theta(2 : end) + t * v;
    r = r - t * A * v;

    s = r' * r / r_old;
    v = r + s * v;

    r_old = r' * r;

    k = k + 1;
  end

end
