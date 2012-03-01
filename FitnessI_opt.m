function [ F ] = FitnessI_opt( ind )
%FitnessI calcule la fitness d'un individu pour le N-queens problem

M = size(ind, 2); % nombre de colonnes
% set left and right diagonal counters to 0

I=1:M;
li = I + ind;
ri = M - I + ind;

li=sort(li);
ri=sort(ri);
F = sum(li((1:end-1))==li(2:end))+sum(ri((1:end-1))==ri(2:end));

end

