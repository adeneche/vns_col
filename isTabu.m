function tabu = isTabu(prblm, sol, n, c, tabulist, nIt, nC, bestNc)

tabu = 0;

if tabulist(n, c)
    if nIt > tabulist(n, c)
        % expired
        tabu = 0;
    else
        % enhanced aspiration criterion
        tabu = 1;
        
        profit = moveProfit(prblm, sol, n, c);
        if (profit + nC) < bestNc
            tabu = 0;
        end
    end
end

end