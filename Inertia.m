function [I] = Inertia(P)
%Intertia computes the moment of inertia for a population 

N = size(P, 1);

% calculer le centroïd de P
C = sum(P, 1) ./ N;

% calculer (Xij - Ci)
x = bsxfun(@minus, P, C);
I = sum(sum(x.^2));