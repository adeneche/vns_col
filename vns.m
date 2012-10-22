function [ best, bestNc, adjcols ] = vns(prblm, sol, maxIt, fixLong, propLong, verbose, adjcols)

if nargin == 5
    verbose = false;
end

if nargin < 7
    adjcols = buildAdjacency(prblm, sol);
end


nC = nodesConflicting(sol, adjcols); % nombre de conflits
bestNc = nC;
best = sol;

iVns = 0;
neigh = 0;

msglen = 0;

while nC > 0 && iVns < prblm.N
    [sol, adjcols] = shake(prblm, sol, neigh, adjcols, iVns);
    
    %TODO we should pass adjcols to ts
    [bestTs, bestNcTs, adjcolsTs] = ts(prblm, sol, maxIt, fixLong, propLong, false, adjcols);
    if bestNcTs < bestNc
        sol = bestTs;
        nC = bestNcTs;
        adjcols = adjcolsTs;
        
        best = bestTs;
        bestNc = bestNcTs;
        
        iVns = 0;
        neigh = 0;
    else
        if mod(iVns, trunc(prblm.N/5)) == 0
            neigh = neigh + 1;
        end
    end

        
    if verbose
        if (nC == 0)
            msg = sprintf('it%10i/%10i\n', nIt, endIt);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
        else%if (mod(nIt, 1000) == 0)
            msg = sprintf('iVns %10i/%10i, neigh %10i, conf: %4i, best: %4i\n', iVns, prblm.N, neigh, nC, bestNc);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
            msglen=numel(msg);
        end
    end

    iVns = iVns + 1;
end

end