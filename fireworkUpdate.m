function [sol, adjcols] = fireworkUpdate(prblm, sol, adjcols, grenadesConflicting, preConflicting)

nG = 0;
for n = 1:prblm.N
    if (grenadesConflicting(n))
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

%         if(nG==0)
%             printf("\tGRENADE-%2d: %2d ->%2d",nG+1,move->color,move->bestNew);
% 		else
% 			printf("\t\t\t\tGRENADE-%2d: %2d ->%2d",nG+1,move->color,move->bestNew);

        if newConf > 0
            % printf(" (%2d) --*",newConf); 
            [sol, adjcols] = grenadeUpdate(prblm, sol, adjcols, newConflicting);
            [~, preConflicting] = getConflictingNodes(sol, adjcols);
        end
        % printf("\n");
    end
end

end