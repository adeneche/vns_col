function [sol, adjcols] = grenadeUpdate(prblm, sol, adjcols, newConflicting)

for n = 1:prblm.N
    if (newConflicting(n))
        % move it to the best possible other color class
        newBest = findBestNodeMove(sol, n, adjcols);
        move = [n sol(n) newBest];
            
        %do the move
        sol(n) = newBest;

        adjcols = updateAdjacency(prblm, sol, adjcols, move);
        
    end
end

end