function [ mutated, fm ] = hypermutation3( individu, leftd, rightd )
%hypermutation: permute 2 cases de l'individu, et calcule la fitness au passage 
mutated= individu;
M = size(individu,2);
% trouver i et j les indices de 2 cases de l'individu tel que i !=j
tmp= randperm2(M);
i = tmp(1);
k = tmp(2);
mutated (i)= individu (k);
mutated (k)= individu (i);

ili = i+individu(i);
leftd(ili) = leftd(ili)-1;
iri = M-i+individu(i);
rightd(iri) = rightd(iri)-1;
kli = k+individu(k);
leftd(kli) = leftd(kli)-1;
kri = M-k+individu(k);
rightd(kri) = rightd(kri)-1;

ilm = i+mutated(i);
leftd(ilm) = leftd(ilm)+1;
irm = M-i+mutated(i);
rightd(irm) = rightd(irm)+1;
klm = k+mutated(k);
leftd(klm) = leftd(klm)+1;
krm = M-k+mutated(k);
rightd(krm) = rightd(krm)+1;

fm = sum(leftd > 1) + sum(rightd > 1);

end