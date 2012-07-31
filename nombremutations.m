function [ nc ] = nombremutations( N,Mut,i,fit)
%nombreclones calcule le nombre de clones d'un certain rangs 
%N= nombre d'individus
% Nc = nombre totale de mutations
% i= le rang d'individus

%TODO implémenter la formule de Dabrowski
%A= (fit/100) * Mut;
A= (N-i)/N * Mut + 1;
%A = fit/5;
%A = i;

nc= ceil (A);
end

