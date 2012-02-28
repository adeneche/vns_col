function [ F ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le N-queens problem

M = size(ind, 2); % nombre de colonnes

I=1:M;
li = I + ind;
ri = M - I + ind;

F = (length(li)-length(unique(li)))+(length(ri)-length(unique(ri)));

end

