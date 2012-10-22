function bestMove = findBestNodeMove(sol, adjcols)
% pour chaque noder/couleur, renvoi le couple qui donne le plus de profit
% si aucun best move trouvé, renvoi empty matrix
% sinon renvoi [n curColor newColor]

%TODO modifier findBest1Move pour permettre d'ignorer tabulist et
%l'utiliser directement

N = length(sol);
K = max(sol);

% identifier les conflicting nodes
%inds = sub2ind(size(adjcols), 1:N, sol);
inds = (sol-1)*N + (1:N);
ac = adjcols(inds);
conflicting = find( ac);

% précalculer profit pour tous les nodes x colors
profits = adjcols(conflicting,:) - repmat(ac(conflicting)', 1, K);

% marquer les moves (n, sol(n)) comme non profitables
inds = (sol(conflicting)-1)*length(conflicting) + (1:length(conflicting)); % inds = sub2ind(size(profits), 1:length(conflicting), sol(conflicting));
profits(inds) = 1000;

[bests, I] = min(profits,[],2);
[~, bestn] = min(bests);
bestc = I(bestn);

bestn = conflicting(bestn);
bestMove = [bestn sol(bestn) bestc];

end