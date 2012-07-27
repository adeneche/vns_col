function tabulist = setTabu(sol, adjcols, n, c, tabulist, nIt, fixLong, propLong)
% marque le move (n,c) comme tabu

propValue = floor( propLong*(nodesConflicting(sol, adjcols)));

tabulist(n, c) = nIt + fixLong+ propValue;

end