function [path] = heuristic_greedy (start_position, probabilities, Adj)
	% start_position -> the starting point in the labyrinth
	% probabilities -> vector of associated probabilities: including WIN and LOSE
	% Adj -> adjacency matrix

	% path -> the states chosen by the algorithm

  path = start_position;
  visited = false(1, length(probabilities));
  visited(start_position) = true;

  while !isempty(path)
    % get last element from path
    position = path(end);

    if probabilities(position) == 1
      % reached WIN state
      return;
    end

    neighbors = find(Adj(position, :) & ~visited);

    if isempty(neighbors)
      path(end) = []; % backtrack
    else
      % get the node with the best probability
      [~, idx] = max(probabilities(neighbors));
      next_node = neighbors(idx);
      visited(next_node) = true;
      path(end + 1) = next_node;
    end
  end

end

