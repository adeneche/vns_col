function [sol, adjcols] = vnsChain(prblm, sol, adjcols, iVns)
% function vnsChain(prblm, sol, adjcols, iVns)
%
% randomly choose a conflicting vertex x (origin vertex) and move it 
% into the best possible other color class Vj. Since sol is a local optimum, 
% this move will create new conflicting vertices in Vj. 
% We then choose at random a new conflicting vertex y ? Vj and assign to it 
% the best possible new color l. This second move will probably create 
% new conflicts in Vl in which case we assign the best possible color to 
% a new conflicting vertex in Vl. This sequence of changes is executed as 
% long as possible, taking care of not changing the color of a vertex more 
% than once. We repeat this process by performing successively i such sequences 
% of changes, with i origin vertices.

% calculer combien de fois on va repeter l'heuristique
d = (iVns*5)/prblm.N;
delta = floor(d*15);
maxIt = 20 - delta;
stopIt = randi(maxIt)+1;

% identifier les conflits avant l'application de Chain
[~, preConflicting] = getConflictingNodes(sol, adjcols);

% printf("VNS: CHAIN C:%d for %d (1..%d)\n",nC,stopIt,maxIt);

for it = 1:stopIt
   % reset history information
   newBest = -1;
   blacklist = false(1, prblm.N);
   
   % randomly choose a conflicting vertex x (origin vertex)
   n = getRandomChainNode(sol, newBest, preConflicting, blacklist);
   if n == -1
       break;
   end
   
   % move it to the best possible other color class
   move = findBestNodeMove(sol, adjcols);
   newBest = move(3);
   
   %do the move
   sol(move(1)) = newBest;
   blacklist(move(1)) = 1;
   
   adjcols = updateAdjacency(prblm, adjcols, move);
   
   % Since sol is a local optimum, this move will create new conflicting 
   % vertices in Vj.
   
   % get current conflicting nodes
   [~, postConflicting] = getConflictingNodes(sol, adjcols);
   
   % get only new conflicting nodes
   newConflicting = ~preConflicting & postConflicting;
   newConf = sum(newConflicting);
   
   preConflicting = postConflicting;
   nC = sum(preConflicting);
   
   if nC == 0
       break;
   end
   
   % printf("(it%2d,C:%3d,%3dnew)%3d ->%3d",it,nC,newConf,move->color,move->bestNew);
   
   if newConf > 0
       % printf(" (%2d) --",newConf);
       
       [sol, adjcols] = chainUpdate(prblm, sol, adjcols, newBest, newConflicting, blacklist);
       preConflicting = postConflicting;
   end
   % printf("\n");
end

end