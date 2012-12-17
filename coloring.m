function sol = coloring(heuristic, instance, startK, minK, maxIt, fixLong, propLong, verbose)

prblm = [];

if nargin == 7
    verbose = false;
end

% load instance
disp('Loading the instance...')
[ prblm.adj, prblm.N, prblm.E ] = loadDimacs(instance);

if (startK == -1)
    % utiliser DSATUR pour trouver uppper bound for K
    disp('Lunching DSATUR...')
    sol = dsatur(prblm.N, prblm.adj)';
    K = max(sol);
    disp([ 'DSATUR a trouvé ' int2str(K) ' couleurs'])
else
    K = startK+1;
end

K = K-1;
prblm.K = K;

improvingK = 1;
while improvingK
    % commencer par une solution aléatoire
    sol = randi(prblm.K, 1, prblm.N);

    disp(['Chercher une ' int2str(prblm.K) ' coloration']);
    improvingK = 0;
    
    [sol, fit] = heuristic(prblm, sol, maxIt, fixLong, propLong, verbose);
    if (fit == 0) % a trouvé une coloration
        disp(['found ' int2str(prblm.K) '-coloration']);
        
        if prblm.K > minK
            prblm.K = prblm.K - 1; % voir si on peut trouver une (K-1)-coloration
            improvingK = 1;
        end
    end
end

end