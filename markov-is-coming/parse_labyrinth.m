function [Labyrinth] = parse_labyrinth(file_path)
	fid = fopen(file_path);

  % get matrix size
  m = textscan(fid, '%d', 1);
  n = textscan(fid, '%d', 1);

  Labyrinth = zeros(m{1}, n{1});

  % read matrix, line by line
  for i = 1 : m{1}
    tmp = textscan(fid, '%d', n{1});
    Labyrinth(i, :) = tmp{1};
  end
  fclose(fid);
end
