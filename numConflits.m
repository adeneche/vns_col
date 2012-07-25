function conflits = numConflits(ind, vertices)

global prblm

N = length(vertices);
conflits = zeros(N, 1);

% pour chaque vertex
for n = 1:N
    v = vertices(n); % num vertex
    adj = prblm.adj(v, :); % adjacence du vertex
    cols = ind(adj == 1); % couleurs adjacentes à v
    conflits(n) = sum(cols == ind(v));
end

end