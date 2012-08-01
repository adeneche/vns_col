function [ P ] = initialisation( N,M,K )

global prblm

%Initialisation créer la matrice initiale P 
% N: nombre des individus (lignes)
% M= nombre des sommets (colonnes)
% k= nombre chromatique 
P = randi(K, N, M);

% inclure la solution de DSATUR dans la population initiale
% if (~isempty(prblm.dsol))
%     P(N,:) = prblm.dsol;
% end

end

