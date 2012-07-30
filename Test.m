function [  ] = Test( instance, minK, numExe, popSize, Nc, Nm, r, S, MaxEvals)
%Test Coloration par AIS

global prblm

% load bpp data files
[ prblm.adj, prblm.N, prblm.E ] = loadDimacs(instance);

fits = zeros(numExe, 1);
evals = zeros(numExe, 1);


for I = 1:numExe
    % utiliser DSATUR pour trouver K initial
    dsol = dsatur(prblm.N, prblm.adj);
    K = max(dsol);

    disp([ 'DSATUR a trouvé ' int2str(K) ' couleurs'])

    % éliminer l'une des couleurs de dsol
    dsol(dsol == K) = K-1;
    K = K-1;

    prblm.dsol = dsol;

    improvingK = 1;

    while improvingK
        disp(['Chercher une ' int2str(K) ' coloration with dsol fit: ' int2str(FitnessI(prblm.dsol)) ]);
        improvingK = 0;
        [fit, sol, eval] = AIS2(popSize, K, Nc, Nm, r, S, MaxEvals);
        if (fit == 0 && K > minK) % a trouvé une coloration
            % eliminer l'une des couleurs aléatoirement 
            numv = sum(sol == K);
            sol(sol == K) = randi(K-1,1,numv); 
            K = K - 1; % voir si on peut trouver une (K-1)-coloration
            prblm.dsol = sol;
            improvingK = 1;
        end
    end
    
    fits(I) = fit;
    evals(I) = eval;
    
    disp(['Execution ' int2str(I) ' best fit : ' int2str(min(fit)) ' evals : ' int2str(eval)])
end

beep

disp(['min : ' int2str(min(fits)) ' mean : ' num2str(mean(fits))]);

end
