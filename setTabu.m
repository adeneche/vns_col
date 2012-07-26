function tabulist = setTabu(prblm, sol, n, c, tabulist, nIt, fixLong, propLong)
% marque le move (n,c) comme tabu

propValue = floor( propLong*(nodesConflicting(prblm, sol)));

tabulist(n, c) = nIt + fixLong+ propValue;

end