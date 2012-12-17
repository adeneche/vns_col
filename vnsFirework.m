function [sol, adjcols] = vnsFirework(prblm, sol, adjcols, iVns)
% function [sol, adjcols] = vnsFirework(prblm, sol, adjcols, iVns)
%
% Randomly choose a conflicting node and move it into the best possible other
% color class. Then consider every nyew conflicting node as a grenade.

global VNSNeighs;

% calculer combien de fois on va repeter l'heuristique
d = ((iVns - (2*prblm.N/VNSNeighs)) * VNSNeighs) / prblm.N;
delta = floor(d*29);
maxIt = 30 - delta;
stopIt = randi(maxIt)+1;

% identifier les conflits avant l'application de firework
[~, preConflicting] = getConflictingNodes(sol, adjcols);

% printf("VNS: FIREWORK C:%d for %d (1..%d)\n",nC,stopIt,maxIt);

for it = 1:stopIt
   % reset history information
   newBest = -1;
         
   % randomly choose a conflicting vertex x (origin vertex)
   n = getRandomChainNode(sol, newBest, preConflicting);
   if n == -1
       break;
   end
   
   % move it to the best possible other color class
   newBest = findBestNodeMove(sol, n, adjcols);
   move = [n sol(n) newBest];
   
   %do the move
   sol(n) = newBest;
   
   adjcols = updateAdjacency(prblm, sol, adjcols, move);
      
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
   
   % printf("(it%2d,C:%3d) %2d ->%2d",it,nC,move->color,move->bestNew);
   
   if newConf > 0
       % printf(" (%2d) --*",newConf);
       
       [sol, adjcols] = fireworkUpdate(prblm, sol, adjcols, newConflicting, preConflicting);
       [~, preConflicting] = getConflictingNodes(sol, adjcols);
   end
   % printf("\n");

   
end

end