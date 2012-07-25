function [ mutated ] = ts(individu, numIter, tabutime)
%ts: applique Tabu Search to the individual
% numItem: nombre d'itérations du tabu search

global prblm;

tabulist = zeros(prblm.N, prblm.K);

mutated = individu;

fit = FitnessI(individu) % nombre de conflits

improved = 0;
iter = 1;

while fit > 0 && improved < numIter
    tabulist(tabulist>0) = tabulist(tabulist>0) - 1;

    [mutated, move] = hypermutation2(mutated, tabulist);
    if (~isempty(move))
        tabulist(move(1), move(2)) = tabutime;
    end
    
    fitn = FitnessI(mutated);
    if (fitn < fit)
        improved = 0;
        fit = fitn;
        %mutated = m;
        disp([num2str(fitn) ' : ' int2str(iter)]);
    else
        improved = improved + 1;
    end
    
    iter = iter + 1;
end

end