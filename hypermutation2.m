function [ mutated, fm ] = hypermutation2( individu, fi )
%hypermutation: permute 2 cases de l'individu, et calcule la new fitness

mutated= individu;
M = size(individu,2);
% trouver i et j les indices de 2 cases de l'individu tel que i !=j
tmp= randperm(M);
i = tmp(1);
k = tmp(2);

mutated (i)= individu (k);
mutated (k)= individu (i);

I = 1:M;
idil = sum((I+individu)==(i+individu(i)));
idir = sum((M-I+individu)==(M-i+individu(i)));
mdil = sum((I+mutated)==(i+mutated(i)));
mdir = sum((M-I+mutated)==(M-i+mutated(i)));

idkl = sum((I+individu)==(k+individu(k)));
idkr = sum((M-I+individu)==(M-k+individu(k)));
mdkl = sum((I+mutated)==(k+mutated(k)));
mdkr = sum((M-I+mutated)==(M-k+mutated(k)));

fm = fi +(mdil==2)+(mdir==2)+(mdkl==2)+(mdkr==2)-(idil==2)-(idir==2)-(idkl==2)-(idkr==2);
if (~isequal(fm, FitnessI_opt(mutated)))
    error('erreur lors du calcul de la fitness')
end
%fm = FitnessI_opt(mutated);

end

 