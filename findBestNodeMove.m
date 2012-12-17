function bestc = findBestNodeMove(sol, n, adjcols)
% pour un node sp�cifique nId, renvoi le couple qui donne le plus de profit
% si aucun best move trouv�, renvoi empty matrix
% sinon renvoi [n curColor newColor]

% modifier cette m�thode pour chercher best move pour un seul node n
profits = adjcols(n, :) - adjcols(n, sol(n));
profits(sol(n)) = 1000; % marquer le move (sol(n)) comme non profitable
[~, bestc] = min(profits);

end