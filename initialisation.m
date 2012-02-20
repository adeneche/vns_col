function [ P ] = initialisation( N,M,K )
%Initialisation cr�er la matrice initiale P 
% N: nombre des individus (lignes)
% M= nombre des sommets (colonnes)
% k= nombre chromatique 
A= rand (N,M);
B= A*K;
P= round (B);
end

