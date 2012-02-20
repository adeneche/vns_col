function [ arreter ] = conditionarret( Fp, MinF, Iter, MaxIter )
%conditionarret:renvoit 1 si l'algorithme a terminé, 0 sinon  
% Fp: Fitness de la population 
% MinF: Fitness de la solution recherchée 
arreter = any(Fp == MinF) || Iter >= MaxIter;
end

