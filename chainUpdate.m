function [sol, adjcols] = chainUpdate(prblm, sol, adjcols, newBest, newConflicting, blacklist)
%function chainUpdate(sol, adjcols, move, newConflicting, blacklist)
%
% We choose at random a new conflicting vertex y ? Vj and assign to it 
% the best possible new color l. This second move will probably create 
% new conflicts in Vl in which case we assign the best possible color to 
% a new conflicting vertex in Vl. This sequence of changes is executed as 
% long as possible, taking care of not changing the color of a vertex more 
% than once.

newConf = sum(newConflicting);
[~, preConflicting] = getConflictingNodes(sol, adjcols);

while (newConf > 0)
    % We choose at random a new conflicting vertex y ? Vj
    id = getRandomChainNode(sol, newBest, newConflicting, blacklist);
    if (id == -1)
        break;
    end
    
    % move it to the best possible other color class
    move = findBestNodeMove(sol, adjcols);
    newBest = move(3);
    
    %do the move
    sol(move(1)) = newBest;
    blacklist(move(1)) = 1;
    
    adjcols = updateAdjacency(prblm, adjcols, move);
    
    % get current conflicting nodes
    [~, postConflicting] = getConflictingNodes(sol, adjcols);
    
    % get only new conflicting nodes
    newConflicting = ~preConflicting & postConflicting;
    
    preConflicting = postConflicting;

    % printf("->%3d ",move->bestNew);
    newConf = sum(newConflicting);
end

end