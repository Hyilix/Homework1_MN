function [decoded_path] = decode_path (path, lines, cols)
	% path -> vector containing the order of the states that arrived
	% 		 to a winning position
	% lines -> numeber of lines
	% cols -> number of columns

	% decoded_path -> vector of pairs (line_index, column_index)
  %                 corresponding to path states
  % hint: decoded_path does not contain indices for the WIN state

  len = length(path);
  max_cell = lines * cols;

  % it is assured that there is a WIN cell
  for i = 1 : len - 1
    elem = path(i);

    % cell is not a WIN cell
    if elem <= max_cell
      y = floor((elem - 1) / cols) + 1;
      x = mod((elem - 1), cols) + 1;
      decoded_path(i, 1 : 2) = [y, x];
    end

  end

end
