function sol = tscoloring(instance, minK, numIter, tabutime)

global prblm

prblm = [];

% load instance
[ prblm.adj, prblm.N, prblm.E ] = loadDimacs(instance);

% utiliser DSATUR pour trouver K initial
dsol = dsatur(prblm.N, prblm.adj);
K = max(dsol);

disp([ 'DSATUR a trouvé ' int2str(K) ' couleurs'])

% éliminer l'une des couleurs de dsol
dsol(dsol == K) = K-1; % = randi(K-1, size(dsol, 1), size(dsol, 2));
K = K-1;

prblm.K = K;

improvingK = 1;
while improvingK
    disp(['Chercher une ' int2str(prblm.K) ' coloration with dsol fit: ' int2str(FitnessI(dsol)) ]);
    improvingK = 0;
    pause(2)
    
    sol = ts(dsol, numIter, tabutime);
    fit = FitnessI(sol);
    if (fit == 0 && prblm.K > minK) % a trouvé une coloration
        % eliminer l'une des couleurs aléatoirement
        sol(sol == prblm.K) = prblm.K - 1;
        prblm.K = prblm.K - 1; % voir si on peut trouver une (K-1)-coloration
        
        dsol = sol;
        improvingK = 1;
    end
end

end