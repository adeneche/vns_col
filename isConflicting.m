function conflict = isConflicting(prblm, sol, n)
% renvoi 1 si le node n de sol a des conflits avec d'autres nodes

adj = prblm.adj(n, :); % adjacence du vertex
cols = sol(adj == 1); % couleurs adjacentes à v

conflict = (sum(cols == sol(n)) > 0);

end