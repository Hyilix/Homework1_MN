function [Y, InitialMatrix] = parse_data_set_file(file_path)
  % path -> a relative path to the .txt file

  % Y -> the vector with all actual values
  % InitialMatrix -> the matrix that must be transformed

  fid = fopen(file_path);

  % get data size
  m = textscan(fid, '%d', 1);
  m = m{1};
  n = textscan(fid, '%d', 1);
  n = n{1};

  InitialMatrix = cell(m, n);
  Y = zeros(m, 1);

  % read matrix, line by line
  for i = 1 : m
    line = fgetl(fid);

    parts = strsplit(strtrim(line));

    % get first element and convert to number
    Y(i) = str2double(parts{1});

    % get each line and put it into InitialMatrix
    for j = 1 : n
      InitialMatrix{i, j} = parts{1 + j};
    end
  end

  fclose(fid);
end
