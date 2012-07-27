function adjcols = buildAdjacency(prblm, sol)
% Build the adjacency matrix from the graph starting status
% adjcols[n][c] = nombre de nodes adjacents à n qui ont la couleur c

adjcols = zeros(prblm.N, prblm.K);

for n = 1:prblm.N
    adj = prblm.adj(n, :); % adjacence du vertex
    cols = sol(adj == 1); % couleurs adjacentes à v
    ucols = unique(cols); % valeur distinctes des couleurs adjacentes
    count = histc(cols, ucols); % nombre de fois que chaque couleur apparait dans la liste d'adjacence
    adjcols(n, ucols) = adjcols(n, ucols) + count;
end

end