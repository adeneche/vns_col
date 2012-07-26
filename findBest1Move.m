function bestMove = findBest1Move(prblm, sol, tabulist, nIt, nC, bestNc)
% pour chaque noder/couleur, renvoi le couple qui donne le plus de profit
% si aucun best move trouvé, renvoi empty matrix
% sinon renvoi [n curColor newColor]

best = 1000;
bestMove = [];

% for each node
for n = 1:prblm.N
    % if the node is conflicting
    if isConflicting(prblm, sol, n)
        % for each possible coloring
        for c = 1:prblm.K
            % except the current color
            if sol(n) ~= c
                %if the move isn't tabu
                if ~isTabu(prblm, sol, n, c, tabulist, nIt, nC, bestNc)
                    % save the best 1 move
                    profit = moveProfit(prblm, sol, n, c);
                    if (profit < best)
                        best = profit;
                        bestMove = [n sol(n) c];
                    end
                end
            end
        end
    end
end

end