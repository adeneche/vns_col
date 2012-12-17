function [ best, bestNc, adjcols ] = vns(prblm, sol, maxIt, fixLong, propLong, verbose, adjcols)

if nargin == 5
    verbose = false;
end

if nargin < 7
    adjcols = buildAdjacency(prblm, sol);
end

global VNSNeighs;
VNSNeighs = 5;

nC = nodesConflicting(sol, adjcols); % nombre de conflits
bestNc = nC;
best = sol;

iVns = 0;
neigh = 0;

msglen = 0;

it = 0;
maxNeigh = 0;
while nC > 0 && iVns < prblm.N
    % disp(['shaking neighborhood ' int2str(neigh)]);
    [sol, adjcols] = shake(prblm, sol, neigh, adjcols, iVns);
    
    % nc = nodesConflicting(sol, adjcols);
    
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
        if mod(iVns, int32(prblm.N/VNSNeighs)) == 0
            neigh = neigh + 1;
            if neigh > maxNeigh
                maxNeigh = neigh;
            end
        end
    end

        
    if verbose
        if (nC == 0)
            msg = sprintf('total iVns %i, max neigh %i\n', it, maxNeigh);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
        else%if (mod(nIt, 1000) == 0)
            msg = sprintf('iVns %4i/%4i (total %4i), neigh %2i, conf: %3i, best: %3i\n', iVns, it, prblm.N, neigh, nC, bestNc);
            fprintf(repmat('\b',1,msglen));
            fprintf(msg);
            msglen=numel(msg);
        end
    end

    iVns = iVns + 1;
    it = it + 1;
end

end