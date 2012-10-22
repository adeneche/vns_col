function [confInds, conflicts] = getConflictingNodes(sol, adjcols)

N = length(sol);

inds = (sol-1)*N + (1:N); % inds = sub2ind(size(adjcols), 1:N, sol);
ac = adjcols(inds); % nombre de nodes adjacents de la même couleur
conflicts = ac > 0;
confInds = find( conflicts);

end