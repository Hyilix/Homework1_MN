
Matrix Numerical Methods - Tema 1
=================================

> URSESCU Sebastian - 315CA (Tema 1 MN)

### Quick Access

[Task 1 - Markov is coming ...](#task-1---markov-is-coming-)

[Task 2 - Linear regression](#task-2---linear-regression)

[Task 3 - MNIST 101](#task-3---mnist-101)

## Tasks

### Task 1 - Markov is coming ...

#### General Overview

Having a maze comprised of cells with walls and WIN/LOSE exits (WIN exits are in the North/South of the maze / LOSE exits are in the East/West of the maze),
the task is to find a path to a WIN exit by calculating possibillities. Each cell is encoded based on what walls are surrounding them. The encoding is as follows:


            b3
        ---------
        |       |
     b0 |       | b1      cell = b3 b2 b1 b0      where b3, b2, b1, b0 are bits
        |       |
        ---------
            b2

It is important to note that many of the following matrices will be sparse. For optimization, Matlab/Octave has a separate way of handling sparse matrices, 
and thus they will be converted using the **sparse** function.

#### Main Functions

* function [Labyrinth] = parse_labyrinth(file_path)
  * Returns a matrix [Labyrinth] of the encoded cells from a file.
  * This is done using the **textscan** function to read each character in the given file.
  * [Labyrinth] is essentialy a matrix full of numbers ranging from 0 to 15.

* function [Adj] = get_adjacency_matrix(Labyrinth)
  * Builds the adjacency matrix for the given Labyrinth. Each cell is assigned a state from 1 to number of cells, and are treated like nodes in a graph.
  * The adjacency matrix will take each node and determine what are their open neighbours (walls will break this connection).
  * The WIN/LOSE are considered nodes and will be counted at the end of the matrix.
  * [Adj] is a *sparse* matrix containing all possible connections between cells.
  
* function [Link] = get_link_matrix(Labyrinth)
  * Builds an adjacency matrix for the given Labyrinth, except it's not only cells that are adjacent, but the probability of choosing each open cell.
  * The WIN/LOSE are considered nodes and will be counted at the end of the matrix.
  * [Link] is a *sparse* matrix containing all possible connections between cells, each element being a floating number ranging from 0 to 1,
    and represents a possibility of the cell being picked.
  
* function [G, c] = get_Jacobi_parameters(Link)
  * Separates the Link matrix into the cells Link matrix (stored in G), and the WIN/LOSE link matrix (stored in c).
  
* function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
  * Solves the x(k + 1) = G * x(k) + c system of equations iteratively, with a given tolerance for error, and a maximum number of steps.
  
* function [path] = heuristic_greedy(start_position, probabilities, Adj)
  * Attempt to pathfind based on taking the cells with the best probability to reach a WIN state (hence the name "greedy").
  * Will save all visited cells in a matrix for eventual backtracking.
  
* function [decoded_path] = decode_path(path, lines, cols)
  * Given a path of indexes of cells, this function will return (y, x) coordinates of each cell index.

#### Custom Functions

For this task, there are several new custom functions that I added:

* function [bin] = int_to_4bit(N)

   * Will convert any 4 bit (or lower) integer to its binary representation in form of a line matrix.
    This approached was chosen over other built-in functions, such as **dec2bin**, because it is zero extended,
    and it's easier to extract each byte from matrix form rather than number form.

      * e.g. dec2bin(4) = 100  |  int_to_4bit(4) = [0 1 0 0]
      * e.g. dec2bin(2) = 10   |  int_to_4bit(2) = [0 0 1 0]

    * This function is useful for converting compact coded cells into a readable format.
    * While technically not needed, it makes it easier and more intuitively to work with.
  
* function openings = get_openings(bin)

    * Gets the number of openings for a given cell. This essentially counts the zeros inside a 4 bit number.

### Task 2 - Linear regression

#### General Overview

Having a set of data with different meaning, it is possible to minimize the function of cost and loss. This algorithm will implement Multiple Linear Regression.

Here is the Multiple Linear Regression formula:

      hTh(x) = Th0 + Th1x1 + Th2x2 + . . . + Thnxn + ε    where Th is Theta

This task requires calculating Theta in two ways, and to implement three types of cost function from a given data set.

#### Main Functions

* function [Y, InitialMatrix] = parse_data_set_file(file_path)
  * Read a file comprised of a matrix with different types of data (numbers and strings).
  * Save the first column (of which the numbers are always numbers) into the column matrix [Y].
  * Save the rest of the matrix inside [InitialMatrix] using the Matlab/Octave built-in way to store differnet types of data **cell**.
  
* function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  * Convert the [InitialMatrix] that contains both numbers and strings to a matrix [FeatureMatrix] that contains only numbers.
  * The "yes/no" are converted to "1/0".
  * The furnished state is replaced with a 2 bit number as follows:
    * "semi-furnished" -> "1 0"
    * "unfurnished"    -> "0 1"
    * "furnished"      -> "0 0"
  * The [FeatureMatrix] will have one extra element as a result.

* function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  * Calculates the cost of linear regression using the formula:
  
        Error = (1 / (2 * m)) * sum(dif .^ 2);

* function [Y, InitialMatrix] = parse_csv_file(file_path)
  * Basically the same as parse_data_set_file(file_path), but instead of reading from a plain text, we read from a .csv file.
  * The key difference is that .csv files don't store the matrix size, so we will read into an arbitrary large matrix until we reach EOF,
    then trim the matrix to hold just what is necessary.
      * Another solution was to dynamically increase the matrix's size with each line read, but this is far more expensive and slower to do in a Matlab/Octave environment.

* function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  * Calculates the [Theta] matrix, iteratively, using the gradient descent method.
  * The first Theta value is always 0.

* function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
  * Calculates the [Theta] matrix using the normal equation method.
  * This requires the [FeaturesMatrix] to be positive definite. To achieve this, all eigenvalues of the matrix must be positive (> 0).
    * [Theta] will be 0 if the condition is not met.
  * The normal equation uses the conjugate gradienth method to bypass calculation of inverse matrix.
  * The first Theta value is always 0.

* function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)
  * Calculates the cost of lasso regression using the following formula:

         Error = 2 * Rerr + lambda * sum(abs(Theta(2 : end)));  where Rerr is the linear regression cost

* function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)
  * Calculates the cost of ridge regression using the following formula:

         Error = Rerr + lambda * sum(Theta(2 : end) .^ 2);  where Rerr is the linear regression cost

### Task 3 - MNIST 101

#### General Overview

Linear regression can be expanded into a logistic regression, which can be expanded into a neural network.

Using forward propagation, we can calculate the predictions and the cost of this neural network.

#### Main Functions

* function [X, y] = load_dataset(path)
  * Load [X] and [y] matrices from a .mat file.
  * X will be used for the training examples

* function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  * Shuffles and splits the [X] and [y] matrices based on the percentage given.
  * Randomness was achieved using the built-in function **randperm(m)** for random sequence of indices.

* function [matrix] = initialize_weights(L_prev, L_next)
  * The weights must be initialised for the learning algorithm to "learn".
  * The [matrix] cannot be initialised with zeros because the learning process will stop.
  * The [matrix] will be initialised with random numbers ranging from -e to e, where:

         e = sqrt(6) / sqrt(L_prev + L_next);      empirical value found

* function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)
  * The cost function of the current parameters and [grad], a matrix obtainted from unrolling the Thetas calculated using back propagation.
  * This is achieved using a sequence of steps:
    * Get the Theta values using built-in function **reshape**.
    * Apply forward propagation.
    * Calculate the cost of the function to get [J].
    * Apply back propagation to calculate deltas.
    * Accumulate the deltas (also removing bias).
    * Unrolling of Thetas to get [grad].

* function [classes] = predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)
  * Returns a vector [classes] with the predictions of the given matrix and weights using forward propagation.
