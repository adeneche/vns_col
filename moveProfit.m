function profit = moveProfit(sol, adjcols, n, c)

% adj = prblm.adj(n, :); % adjacence du vertex
% cols = sol(adj == 1); % couleurs adjacentes à n

% substract the profit given by leaving the current color
% is the number of conflicting nodes that can be lost
% profit = -sum(cols == sol(n));
profit = -adjcols(n, sol(n));

% sum the loss given by entering in the new class
% number of new conflicting nodes added
% profit = profit + sum(cols == c);
profit = profit + adjcols(n, c);

end