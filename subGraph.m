function [sadj, sN, sE] = subGraph(adj, vertices)

sN = length(vertices);
sadj = adj(vertices, vertices);
sE = sum(sum(sadj));

end