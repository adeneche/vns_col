function [ P, Fp ] = Select( Fc, C, S, N )
% select:  s�lection d'une nouvelle population a partir de clones
%
% Fc: Vecteur qui contient l'affinit� des clones
% C: matrice qui contient les clones
% S: taille du tournoi
% pr:probabilit�
% N: nombre d'individus

[nc, M] = size(C);
S = min(nc, S);

P= zeros(N,M);
Fp = zeros(N, 1);

for i=1:N
    
    % 1. choisir S (taille du tournoi) al�atoirement  de la population C
    Y= randsample(nc,S); % Y contient les indices des individus selected pour le tournoi
    
    Fz= Fc(Y); % fitness des individus selected
    
    % choisir le meilleur individu du tournoi
    [minf, mini] = min(Fz);
    indice = Y(mini); % indice du selected clone dans C
    
    individu = C (indice,:);
    P(i, :)= individu;
    Fp(i) = minf;
end

end

