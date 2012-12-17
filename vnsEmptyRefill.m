function [sol, adjcols] = vnsEmptyRefill(prblm, sol, adjcols)
% First empty the color class wich contains the largest number of conflicting 
% nodes by moving each of its nodes into the best possible other color class, 
% then refill the class by successively choosing an equal number of others 
% nodes (new conflicting nodes when possible).

% identifier les conflits avant l'application de Chain
[~, preConflicting] = getConflictingNodes(sol, adjcols);

maxConflict = -1;

% Find the color class with largest number of conflicting nodes
for c = 1:prblm.K
    % count conflicting nodes in color class c
    % cc = countColorConflicting(sol, nC, nextClass, conflicting, blacklist);
    temp = (sol == c) & preConflicting;
    cc = sum(temp);
    if cc > maxConflict
        maxConflict = cc;
        maxColor = c;
    end
end

jmax = 0;

% Empty the color class
for n = 1:prblm.N
    if (sol(n) == maxColor)
        jmax = jmax + 1;
        % get the best move for the current node
        newBest = findBestNodeMove(sol, n, adjcols);
        move = [n sol(n) newBest];
           
        %do the move
        sol(n) = newBest;
   
        adjcols = updateAdjacency(prblm, sol, adjcols, move);

        nC = nodesConflicting(sol, adjcols);
        if nC == 0
            break;
        end
    end
end

% printf("VNS: EMPTY-REFILL: Emptying Color class %d (%d->0), Moved %d nodes\n",maxColor,maxConflict,jmax);
   
% get current conflicting nodes
[~, postConflicting] = getConflictingNodes(sol, adjcols);
   
% get only new conflicting nodes
newConflicting = ~preConflicting & postConflicting;
newConf = sum(newConflicting);

if newConf == 0
    return;
end

j = 0;
% printf("VNS: EMPTY-REFILL: New conflicts: %2d->%2d emptying class %d\n",maxConflict,newConf,maxColor);
for n = 1:prblm.N
    if (newConflicting(n))
        j = j + 1;
        % get the best move for the current node
        newBest = findBestNodeMove(sol, n, adjcols);
        move = [n sol(n) newBest];
           
        %do the move
        sol(n) = newBest;
			
		% printf("n %d:%2d updating (%2d ->%2d)\n",j,move->id,move->color,move->bestNew);

        adjcols = updateAdjacency(prblm, sol, adjcols, move);

        nC = nodesConflicting(sol, adjcols);
        if nC == 0
            return;
        end
        
        if j == jmax
            break;
        end
    end
end
	
end