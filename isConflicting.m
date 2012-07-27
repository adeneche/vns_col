function conflict = isConflicting(sol, adjcols, n)
% renvoi 1 si le node n de sol a des conflits avec d'autres nodes

conflict = adjcols(n, sol(n)) > 0;

end