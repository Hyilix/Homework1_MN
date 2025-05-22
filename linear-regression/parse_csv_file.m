function [Y, InitialMatrix] = parse_csv_file(file_path)
  % path -> a relative path to the .csv file

  % Y -> the vector with all actual values
  % InitialMatrix -> the matrix that must be transformed

  % since csvread can only read numeric data,
  % we will not be able to use this function
  % the matrices will be realocated to fit perfectly

  fid = fopen(file_path);

  % clear header
  header_line = fgetl(fid);
  header_line = strsplit(header_line, ",");

  % get number of columns from the header
  n = size(header_line)(2) - 1;

  % arbitrary large number
  big_m_number = 1000000;
  actual_m = 0;

  InitialMatrix = cell(big_m_number, n);
  Y = zeros(big_m_number, 1);

  % read matrix, line by line
  for i = 1 : big_m_number
    % we have reached EOF, stop
    if feof(fid)
      Y = Y(1 : actual_m, 1);
      InitialMatrix = InitialMatrix(1 : actual_m, :);
      fclose(fid);
      return;
    end
    actual_m++;
    line = fgetl(fid);

    parts = strsplit(line, ",");

    % get first element and convert to number
    Y(i) = str2double(parts{1});

    % get each line and put it into InitialMatrix
    for j = 1 : n
      InitialMatrix{i, j} = parts{1 + j};
    end
  end

  Y = Y(1 : actual_m, 1);
  InitialMatrix = InitialMatrix(1 : actual_m, :);
  fclose(fid);
end
