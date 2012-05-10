function [ arreter ] = conditionarret( Fp, MinF, Iter, lastImproved, MaxIter )
%conditionarret:renvoit 1 si l'algorithme a termin�, 0 sinon  
% Fp: Fitness de la population 
% MinF: Fitness de la solution recherch�e 
% Iter: iteration courante
% lastImproved: num iterations depuis la improved fitness
% MaxIter: num iterations before stopping

arreter = any(floor(Fp) == MinF) || lastImproved >= MaxIter;
end

