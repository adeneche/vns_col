function [ mutated, fm ] = hypermutation( individu )
%hypermutation: permute 2 cases de l'individu
mutated= individu;
M = size(individu,2);
% trouver i et j les indices de 2 cases de l'individu tel que i !=j
tmp= randperm2(M);
i = tmp(1);
k = tmp(2);
mutated (i)= individu (k);
mutated (k)= individu (i);

fm = Fitness2I(mutated);

end

 