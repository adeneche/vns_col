function [ fit ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le problème du 1-BPP
% utilise Next Fit strategy
global prblm;

% Next-Fit
%
% fit = 0;
% sum = 0;
% 
% for i = 1:prblm.N
%     wi = prblm.W(ind(i));
%     sum = sum + wi;
%     if  (sum > prblm.C)
%         sum = wi;
%         fit = fit + 1;
%     end
% end
% 
% if (sum > 0)
%     fit = fit + 1;
% end

% First Fit
%
bins = ones(prblm.N, 1)*prblm.C; % au départ tous les bins sont vides

for i = 1:prblm.N
    wi = prblm.W(ind(i));
    binI = find(bins - wi >= 0); % capacité des bins si on place i dedans
    bins(binI(1)) = bins(binI(1)) - wi; % placer i dans 1er bin libre
end

fit = sum(bins < prblm.C); % nombre de bins occupés

free = max(bins(bins < prblm.C)); % espace libre le plus grand
fit = fit + (1 - free/(prblm.C*prblm.N)); % favoriser un individu qui a un grand espace libre dans un bin

% Best Fit
%
% bins = ones(prblm.N, 1)*prblm.C; % au départ tous les bins sont vides
% 
% for i = 1:prblm.N
%     wi = prblm.W(ind(i));
%     minI = find(bins == min(bins(bins - wi >= 0)));
%     bins(minI(1)) = bins(minI(1)) - wi; % placer i dans 1er bin libre le plus petit
% end
% 
% fit = sum(bins < prblm.C); % nombre de bins occupés
% 
end
