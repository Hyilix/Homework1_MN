function openings = get_openings(bin)
  % function to get available openings for a cell
  openings = 0;
  for x = 1 : 4
    if bin(x) == 0
      openings++;
    end
  end
end
