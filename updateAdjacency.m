function adjcols = updateAdjacency(prblm, adjcols, move)
% update the adjacency matrix from the current move and the graph status

% for each adjacent node
vadj = find(prblm.adj(move(1), :));
for v = vadj
    % decrement column with same old color
    adjcols(v, move(2)) = adjcols(v, move(2))- 1;
    % increment column with same new color
    adjcols(v, move(3)) = adjcols(v, move(3)) + 1;
end

end