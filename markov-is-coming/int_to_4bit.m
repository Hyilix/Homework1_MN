function [bin] = int_to_4bit(N)
  % function to convert int to 4 bits binary
  % used to determine where are the walls

  bin = zeros(1, 4);

  for i = 1 : 4
    tmp = 2 ^ (4 - i);
    bin(i) = (N >= tmp);

    if bin(i)
      N = N - tmp;
    end

  end
end
