function [ nc ] = nombreclones( N,Nc,i)
%nombreclones calcule le nombre de clones d'un certain rangs 
%N= nombre d'individus
% Nc = nombre totale de clones
% i= le rang d'individus
A= (2*Nc*(N-i))/(N*(N-1));
nc= round (A);
end

