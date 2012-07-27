function bestMove = findBest1Move(sol, adjcols, tabulist, nIt, nC, bestNc)
% pour chaque noder/couleur, renvoi le couple qui donne le plus de profit
% si aucun best move trouvé, renvoi empty matrix
% sinon renvoi [n curColor newColor]

N = length(sol);
K = max(sol);

best = 1000;
bestMove = [];

% for each node
for n = 1:N
    % if the node is conflicting
    if isConflicting(sol, adjcols, n)
        % for each possible coloring
        for c = 1:K
            % except the current color
            if sol(n) ~= c
                %if the move isn't tabu
                if ~isTabu(sol, adjcols, n, c, tabulist, nIt, nC, bestNc)
                    % save the best 1 move
                    profit = moveProfit(sol, adjcols, n, c);
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