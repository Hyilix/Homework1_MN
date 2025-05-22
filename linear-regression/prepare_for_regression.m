function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  % InitialMatrix -> the matrix that must be transformed

  % FeatureMatrix -> the matrix with all training examples

  [m n] = size(InitialMatrix);
  FeatureMatrix = zeros(m, n + 1);

  for y = 1 : m
    feature_col = 1;
    for x = 1 : n
      state = InitialMatrix{y, x};

      % convert yes/no to 1/0
      if strcmp(state, "yes")
        FeatureMatrix(y, feature_col) = 1;
      elseif strcmp(state, "no")
        FeatureMatrix(y, feature_col) = 0;

      % convert the fournished state and parse it
      elseif strcmp(state, "furnished")
        FeatureMatrix(y, feature_col) = 0;
        FeatureMatrix(y, feature_col + 1) = 0;
        feature_col++;
      elseif strcmp(state, "unfurnished")
        FeatureMatrix(y, feature_col) = 0;
        FeatureMatrix(y, feature_col + 1) = 1;
        feature_col++;
      elseif strcmp(state, "semi-furnished")
        FeatureMatrix(y, feature_col) = 1;
        FeatureMatrix(y, feature_col + 1) = 0;
        feature_col++;

      % just parse the numbers
      else
        FeatureMatrix(y, feature_col) = str2double(InitialMatrix{y, x});
      end
      feature_col++;
    end
  end
end
