function [sol, adjcols] = shake(prblm, sol, neigh, adjcols, iVns)

% Tester avec chain N.S. uniquement
[sol, adjcols] = vnsChain(prblm, sol, adjcols, iVns);

% switch neigh
%     case 0
%         [sol, adjcols] = vnsChain(prblm, sol, adjcols, iVns);
%         return;
%     case 1
%         [sol, adjcols] = vnsGrenade(prblm, sol, adjcols, iVns);
%         return;
%     case 2
%         [sol, adjcols] = vnsFirework(prblm, sol, adjcols, iVns);
%         return;
%     case 3
%         [sol, adjcols] = vnsEmptyRefill(prblm, sol, adjcols);
%         return;
%     otherwise
%         [sol, adjcols] = randomConflictingColor(sol, adjcols);
%         [sol, adjcols] = vnsEmptyRefill(prblm, sol, adjcols);
% end

end