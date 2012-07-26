function nC = nodesConflicting(prblm, sol)
% renvoi le nombre de nodes qui ont un conflit

nC = 0;

% pour chaque vertex
for v = 1:prblm.N
    nC = nC + isConflicting(prblm, sol, v);
end


end