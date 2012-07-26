function [ best ] = ts(prblm, sol, maxIt, fixLong, propLong)
%ts: applique Tabu Search to the individual
% numItem: nombre d'itérations du tabu search

tabulist = zeros(prblm.N, prblm.K);

nIt = 0;
nC = nodesConflicting(prblm, sol); % nombre de conflits
bestNc = nC;
best = sol;

endIt = maxIt;

msglen = 0;

while nC > 0 && nIt < endIt
    nIt = nIt + 1;
    
    % chercher le move qui a le plus grand profit et qui n'est pas tabou
    move = findBest1Move(prblm, sol, tabulist, nIt, nC, bestNc);
    if isempty(move)
        continue;
    end
    
    % marquer le move comme tabou
    tabulist = setTabu(prblm, sol, move(1), move(2), tabulist, nIt, fixLong, propLong);

    % appliquer le best 1move trouvé
    sol(move(1)) = move(3);

    nC = nodesConflicting(prblm, sol);
    
    if (nC < bestNc)
        bestNc = nC;
        endIt = nIt + maxIt;
        best = sol;
    end
    
    msg = sprintf('it%10i/%10i | conf: %4i, best: %4i\r', nIt, endIt, nC, bestNc);
    fprintf(repmat('\b',1,msglen));
    fprintf(msg);
    msglen=numel(msg);
end

end