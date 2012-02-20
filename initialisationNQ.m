function [ P ] = initialisationNQ( N,M )
%initialisationNQ: Cr�er la matrice initiale P, pour le probl�me de M
%queens 
% N: Nombre des individus (solutions, lignes)
% M: Nombre de queens 
P = zeros (N, M);
for i=1:N
    P(i,:)= randperm (M);
end
end