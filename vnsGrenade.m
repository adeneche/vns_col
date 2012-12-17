function [sol, adjcols] = vnsGrenade(prblm, sol, adjcols, iVns)
% function [sol, adjcols] = vnsGrenade(prblm, sol, adjcols, iVns)
%
% Grenade neighborhood:
% Randomly choose a conflicting node and move it into the best possible other
% color class. Move each new conflicting node from the arriving class into the
% best possible other color class. This process is repeated with I different
% grenade.

global VNSNeighs;

% calculer combien de fois on va repeter l'heuristique
d = ((iVns - (prblm.N/VNSNeighs)) * VNSNeighs) / prblm.N;
delta = floor(d*39);
maxIt = 40 - delta;
stopIt = randi(maxIt)+1;

% identifier les conflits avant l'application de Chain
[~, preConflicting] = getConflictingNodes(sol, adjcols);

% printf("VNS: GRENADE C:%d for %d (1..%d)\n",nC,stopIt,maxIt);

for it = 1:stopIt
   % randomly choose a conflicting vertex x (origin vertex)
   n = getRandomChainNode(sol, -1, preConflicting);
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

   % printf("(it%2d,C:%3d) %3d ->%3d",it,nC,move->color,move->bestNew);

      
   if newConf > 0
       % printf(" (%2d) --*",newConf);
       
       [sol, adjcols] = grenadeUpdate(prblm, sol, adjcols, newConflicting);
       [~, preConflicting] = getConflictingNodes(sol, adjcols);
   end
   % printf("\n");

end

end