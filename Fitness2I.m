function [ fit ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le Vertex Coloring Problem

global prblm;

counts = zeros(prblm.N,1);
colors = zeros(prblm.N, 1); % couleur de chaque node
freecols = ones(prblm.N, prblm.N); % couleurs dispos pour chaque node

for i = 1:prblm.N % pour chaque noeud
    
    fcols = find(freecols(ind(i),:)); % couleurs disponibles pour le node ind(i)
    c = fcols(1); % choisir la 1ère couleur disponible
    
    colors(ind(i)) = c;
    counts(c) = counts(c) + 1;
    
    % mettre à jour les couleurs disponibles pour les nodes adjacents à
    % ind(i)
    adjn = prblm.adj(ind(i), :); % nodes adjacents à ind(i)
    freecols(adjn>0, c) = 0; % la couleur c n'est plus dispo pour ces nodes
end

% tous les nodes ont été colorés
fit = max(colors); % nombre de couleurs utilisées

% num nodes de la couleur la plus petite
cnts = sort(counts(counts>0));

min1 = cnts(1)/prblm.N;
min2 = cnts(2)/(prblm.N*prblm.N);
fit = fit + min1 + min2;

end
