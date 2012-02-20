function [ mutated, fm ] = hypermutation( individu, fi )
%hypermutation: permute 2 cases de l'individu
mutated= individu;
M = size(individu,2);
% trouver i et j les indices de 2 cases de l'individu tel que i !=j
tmp= randperm(M);
i = tmp(1);
k = tmp(2);
mutated (i)= individu (k);
mutated (k)= individu (i);

fm = FitnessI(mutated);
end

 