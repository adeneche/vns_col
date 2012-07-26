function [ mutated, bestmove ] = hypermutation2( individu, tabumoves )
%hypermutation2: choisit la mutation qui améliore le plus le score
global prblm

N = prblm.N;
K = prblm.K;

if (nargin == 1)
    tabumoves = zeros(prblm.N, prblm.K);
end

% calculer le nombre de conflits pour chaque vertex
conflits = numConflits(individu, 1:N);

% identifier les nodes qui ont des conflits
nodes = find(conflits > 0)';

best = intmax;
bestmove = [];

colors = 1:K;

% for each node n qui est a des conflits
for n = nodes
    for c = colors
        % pour chaque couleur, sauf la couleur de n
        if (c == individu(n))
            continue;
        end
        
        % calculer le profit du move (n,c)
        newconf = sum( individu(prblm.adj(n,:) == 1) == c); % nombre de nodes adjacents à n avec la couleur c
        profit = newconf - conflits(n); % profit du move
        
        
        if (profit < best) % new best move found
            if (profit < 0) % si le move améliore la fitness, ne pas vérifier s'il est tabu
                best = profit;
                bestmove = [n, c];
            elseif (tabumoves(n, c) == 0)
                best = profit;
                bestmove = [n, c];
            end
        end
    end
end

% appliquer le best move
mutated = individu;
if (~isempty(bestmove))
    mutated(bestmove(1)) = bestmove(2);
end

end

 