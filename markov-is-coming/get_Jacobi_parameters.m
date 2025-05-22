function [G, c] = get_Jacobi_parameters (Link)
	% Link -> the link matrix (edge with probabilities matrix)

  % G -> iteration matrix
	% c -> iteration vector

  [m, n] = size(Link);

  G = Link(1 : m - 2, 1 : m - 2);

  c = Link(1 : m - 2, m - 1);

end
