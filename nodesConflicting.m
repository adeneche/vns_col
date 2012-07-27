function nC = nodesConflicting(sol, adjcols)
% renvoi le nombre de nodes qui ont un conflit

N = length(sol);
nC = 0;

% pour chaque node
for n = 1:N
    nC = nC + (adjcols(n, sol(n)) > 0);
end


end