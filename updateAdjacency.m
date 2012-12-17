function adjcols = updateAdjacency(prblm, sol, adjcols, move)
% update the adjacency matrix from the current move and the graph status

% for each adjacent node
vadj = find(prblm.adj(move(1), :));

% decrement column with same old color
adjcols(vadj, move(2)) = adjcols(vadj, move(2)) - 1;
% increment column with same new color
adjcols(vadj, move(3)) = adjcols(vadj, move(3)) + 1;

end