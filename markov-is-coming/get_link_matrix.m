function [Adj] = get_link_matrix (Labyrinth)
	[m, n] = size(Labyrinth);

  state_count = m * n + 2;

  Adj = zeros(state_count, state_count);

  for i = 1 : state_count
    if (i <= m * n) % for the cells
      % get matrix coordinates
      y = floor((i - 1) / n) + 1;
      x = mod((i - 1), n) + 1;

      elem = Labyrinth(y, x);
      bin = int_to_4bit(elem);
      openings = get_openings(bin);

      for j = 1 : i
        % get matrix coordinates of new element
        Y = floor((j - 1) / n) + 1;
        X = mod((j - 1), n) + 1;

        Elem = Labyrinth(Y, X);
        Bin = int_to_4bit(Elem);
        Openings = get_openings(Bin);

        % check for adjacency
        if sqrt((x - X) ^ 2 + (y - Y) ^ 2) == 1
          if x > X && bin(4) == 1
            continue;
          end
          if y > Y && bin(1) == 1
            continue;
          end

          % no walls
          Adj(i, j) = 1 / openings;
          Adj(j, i) = 1 / Openings;
        end
      end

    else  % for the WIN/LOSE states
      for j = 1 : m * n
        % get matrix coordinates
        y = floor((j - 1) / n) + 1;
        x = mod((j - 1), n) + 1;

        elem = Labyrinth(y, x);
        bin = int_to_4bit(elem);
        openings = get_openings(bin);

        % check for edge cells
        % check for win
        if y == 1 && bin(1) == 0 && i == state_count - 1
          Adj(j, i) = 1 / openings;
        end
        if y == m && bin(2) == 0 && i == state_count - 1
          Adj(j, i) = 1 / openings;
        end
        % check for lose
        if x == 1 && bin(4) == 0 && i == state_count
          Adj(j, i) = 1 / openings;
        end
        if x == n && bin(3) == 0 && i == state_count
          Adj(j, i) = 1 / openings;
        end
      end

    end
  end

  % assign win -> win | lose -> lose
  Adj(state_count - 1, state_count - 1) = 1;
  Adj(state_count, state_count) = 1;

  Adj = sparse(Adj);

end
