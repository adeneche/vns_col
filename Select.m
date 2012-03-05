function [ P, Fp ] = Select( Fc,C,S,pr,N )
% select:  sélection d'une nouvelle population a partir de clones 
%   Detailed explanation goes here
% Fc: Vecteur qui contient l'affinité des clones 
% C: matrice qui contient les clones
% S: taille du tournoi
% pr:probabilité
% N: nombre d'individus 

[nc,M] = size(C);
S = min(nc, S);

P= zeros(N,M);
Fp = zeros(N, 1);

for i=1:N
    % 1. choisir S (taille du tournoi)aléatoirement  de la population C
    [a,b] =size (C);
    Y= randsample (a,S); % Y contient les indices des individus selected pour le tournoi
    %Z= C(Y,:);
    % 2. choisir le meilleur individu du tournoi avec la probabilité P
    % 3. choisir le 2 éme meilleur individus de tournou avec la probabilité P*(1-P)
    ..... I.choisir le I éme meilleur P*(1-P)ous(i-1)

    %calcule le vecteur de probabilités W 

    Fz= Fc(Y);% calcule la fitness des individus dans Z
    [A , R]= sort (Fz);% R est le rang des individus dans Z
    Y2= Y(R); %les Y sont triés par R selon la fitness 
    R2= 1:S;
    w= pr*(1-pr).^(R2-1);
    indice = randsample(Y2,1,true,w);% la selection d'un seul individu dans Z 
    individu = C (indice,:);
    P(i, :)= individu;
    Fp(i) = Fc(indice);
 end 
end

