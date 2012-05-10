function [ arreter ] = conditionarret( Fp, MinF, Iter, lastImproved, MaxIter )
%conditionarret:renvoit 1 si l'algorithme a terminé, 0 sinon  
% Fp: Fitness de la population 
% MinF: Fitness de la solution recherchée 
% Iter: iteration courante
% lastImproved: num iterations depuis la improved fitness
% MaxIter: num iterations before stopping

arreter = any(floor(Fp) == MinF) || lastImproved >= MaxIter;
end

