function [ mutated ] = ts(individu, numIter, tabutime)
%ts: applique Tabu Search to the individual
% numItem: nombre d'itérations du tabu search

global prblm;

tabulist = zeros(prblm.N, prblm.N);

mutated = individu;

fit = Fitness2I(individu)

for i = 1:numIter
    tabulist(tabulist>0) = tabulist(tabulist>0) - 1;
    
    r = randperm2(prblm.N); % 2 entier aléatoire non égaux
    while tabulist(r(1), r(2)) > 0 % r n'est pas dans la tabu list
        r = randperm2(prblm.N);
    end
    
    m = mutated;
    m (r(1))= mutated (r(2));
    m (r(2))= mutated (r(1));
    
    tabulist(r(1), r(2)) = tabutime;
    tabulist(r(2), r(1)) = tabutime;
    
    fitn = Fitness2I(m);
    if (fitn < fit)
        fit = fitn;
        mutated = m;
        disp([num2str(fitn) ' : ' int2str(i)]);
    end
    
end

end