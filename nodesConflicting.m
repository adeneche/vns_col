function nC = nodesConflicting(sol, adjcols)
% renvoi le nombre de nodes qui ont un conflit

N = length(sol);
% nC = 0;
% 
% % pour chaque node
% for n = 1:N
%     nC = nC + (adjcols(n, sol(n)) > 0);
% end

%inds = sub2ind(size(adjcols), 1:N, sol);
inds = (sol-1)*N + (1:N);
nC = sum( adjcols(inds) > 0);

end