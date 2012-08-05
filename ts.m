function [ best, bestNc ] = ts(prblm, sol, maxIt, fixLong, propLong, verbose)
%ts: applique Tabu Search to the individual
% numItem: nombre d'itérations du tabu search

if nargin == 5
    verbose = false;
end

tabulist = zeros(prblm.N, prblm.K);

adjcols = buildAdjacency(prblm, sol);

nIt = 0;
nC = nodesConflicting(sol, adjcols); % nombre de conflits
bestNc = nC;
best = sol;

endIt = maxIt;

msglen = 0;

while nC > 0 && nIt < endIt
    nIt = nIt + 1;
    
    % chercher le move qui a le plus grand profit et qui n'est pas tabou
    move = findBest1Move(sol, adjcols, tabulist, nIt, nC, bestNc);
    if isempty(move)
        continue;
    end
    
    % marquer le move comme tabou
    tabulist = setTabu(sol, adjcols, move(1), move(2), tabulist, nIt, fixLong, propLong);
    
    % appliquer le best 1move trouvé
    sol(move(1)) = move(3);

    adjcols = updateAdjacency(prblm, adjcols, move);

    nC = nodesConflicting(sol, adjcols);
    
    if (nC < bestNc)
        bestNc = nC;
        endIt = nIt + maxIt;
        best = sol;
    end
    
    if verbose
        if (nC == 0)
            msg = sprintf('it%10i/%10i\n', nIt, endIt);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
        else%if (mod(nIt, 1000) == 0)
            msg = sprintf('it%10i/%10i conf: %4i, best: %4i\n', nIt, endIt, nC, bestNc);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
            msglen=numel(msg);
        end
    end
end

end