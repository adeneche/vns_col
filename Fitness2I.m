function [ fit ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le Vertex Coloring Problem

global prblm;

colors = zeros(prblm.N, 1); % couleur de chaque node
freecols = ones(prblm.N, prblm.N); % couleurs dispos pour chaque node

for i = 1:prblm.N % pour chaque noeud
    
    fcols = find(freecols(ind(i),:)); % couleurs disponibles pour le node ind(i)
    c = fcols(1); % choisir la 1�re couleur disponible
    colors(ind(i)) = c;
    
    % mettre � jour les couleurs disponibles pour les nodes adjacents �
    % ind(i)
    adjn = prblm.adj(ind(i), :); % nodes adjacents � ind(i)
    freecols(adjn>0, c) = 0; % la couleur c n'est plus dispo pour ces nodes
end

% tous les nodes ont �t� color�s
fit = max(colors); % nombre de couleurs utilis�es

end
