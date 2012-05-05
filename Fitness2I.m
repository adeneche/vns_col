function [ fit ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le Vertex Coloring Problem

global prblm;

colors = zeros(prblm.N, 1); % couleur de chaque node

for i = 1:prblm.N % pour chaque noeud
    
    adjn = prblm.adj(ind(i), :); % nodes adjacents � ind(i)
    cols = colors(adjn>0); % couleurs des nodes adjacents � ind(i)
    cols = cols(cols>0); % garder uniquement les couleurs non 0
    
    if (isempty(cols))
        c = 1;
    else
        freecols = 1:prblm.N; % couleurs disponibles
        freecols(cols(:)) = 0; % couleurs occup�es par les adjacents � ind(i)    
        freecols = find(freecols); % n� des couleurs libres
        c = freecols(1);
    end
    
    % le node i a la couleur c
    colors(ind(i)) = c;
end

% tous les nodes ont �t� color�s
fit = max(colors); % nombre de couleurs utilis�es

end
