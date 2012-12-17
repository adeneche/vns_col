function bestc = findBestNodeMove(sol, n, adjcols)
% pour un node spécifique nId, renvoi le couple qui donne le plus de profit
% si aucun best move trouvé, renvoi empty matrix
% sinon renvoi [n curColor newColor]

% modifier cette méthode pour chercher best move pour un seul node n
profits = adjcols(n, :) - adjcols(n, sol(n));
profits(sol(n)) = 1000; % marquer le move (sol(n)) comme non profitable
[~, bestc] = min(profits);

end