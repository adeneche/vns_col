function [ F ] = Fitness2I( ind )
%Fitness2I calcule la fitness d'un individu pour le N-queens problem

M = size(ind, 2); % nombre de colonnes

I=1:M;
li = I + ind;
ri = M - I + ind;

%F = (length(li)-length(unique(li)))+(length(ri)-length(unique(ri)));

li=sort(li);
ri=sort(ri);
F = sum(li((1:end-1))==li(2:end))+sum(ri((1:end-1))==ri(2:end));

end
