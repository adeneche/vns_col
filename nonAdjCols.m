function cols = nonAdjCols(n, adj, colors)
%NONADJCOLS: renvoit la liste de couleurs non adjacentes � n
% n: node pour lequel on cherche les couleurs non adjacentes
% 
numc = max(colors);
cols = zeros(numc,1);

% identifier les couleurs adjacentes � n
cols( colors( find( adj(n,:) == 1))) = 1;

cols = find(cols == 0); % couleurs non adjacentes � n
cols(cols == colors(n)) = []; % enlever la couleur de n