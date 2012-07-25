function [ mutated ] = hypermutation( individu, numMutations )
%hypermutation: permute 2 cases de l'individu
global prblm

N = prblm.N;

mutated= individu;

%TODO implémenter la mutation de Dabrowski
%TODO nombre de vertex mutated

vertices = 1:N; % on commence par considérer tous les vertex
choosen = zeros(N,1);

for i = 1:numMutations
    % calculer le nombre de conflits pour chaque vertex à considerer
    conflits = numConflits(mutated, vertices);
    fit = sum(conflits);
    if (fit == 0) 
        return; % aucun vertex n'a de conflits
    end
    
    % choisir un vertex proportionelement à son nombre de conflits
    if (length(vertices) == 1)
        v = vertices;
    else
        v = randsample(vertices, 1, true, conflits/fit);
    end
    
    % calculer le nombre de vertex adjacents pour chaque couleur
    a = prblm.adj(v,:); % vertex adjacents à v
    cols = individu(a == 1); % couleurs adjacentes à v
    ucols = unique(cols); % valeur distinctes des couleurs adjacentes
    count = histc(cols, ucols); % nombre de fois que chaque couleur apparait dans la liste d'adjacence

    colors = zeros(prblm.K, 1);
    colors(ucols) = count; % nombre de fois que chaque couleur apparait dans l'adjacence

%     candidates = find(colors == min(colors));
%     if (length(candidates) > 1 )
%         % choisir la couleur qui minimise le nombre de conflits
%         c = randsample(candidates, 1);
%     else
%         c = candidates;
%     end
    
    % choisir la couleur qui a le moins de vertex adjacents
    % c = randsample(1:prblm.K, 1, true, 1 - colors / sum(colors));
    invcolors = max(colors) - colors + 1; % la probabilité est inversement proportionelle
    c = randsample(1:prblm.K, 1, true, invcolors / sum(invcolors));

    mutated(v) = c;

    choosen(v) = 1;
    
    adj = prblm.adj(v,:); % chercher le prochain vertex parmis les voisins de n
    adj(choosen == 1) = 0; % ignorer les vertices déjà parcourus
    vertices = find(adj);
end

end

 