function [sol, adjcols] = randomConflictingColor(prblm, sol, adjcols)
% each conflicting node is affected with a random color

[confInds,~] = getConflictingNodes(sol, adjcols);
sol(confInds) = randi(prblm.K, 1, length(confInds));

adjcols = buildAdjacency(prblm, sol);

end