function [  ] = Test( instance, minK, hais, numExe, popSize, Nc, Nm, r, S, MaxIter, draw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global wbh prblm

wbh = waitbar(0,'Initializing waitbar...');

disp(['Executing ' func2str(hais)]);

if (draw == 1)
    numExe = 1;
end

% load bpp data files
[ prblm.adj, prblm.N, prblm.E ] = loadDimacs(instance);
prblm.minF = 0;

fits = zeros(numExe, 1);
iters = zeros(numExe, 1);
ts = zeros(numExe, 1);


for I = 1:numExe
    waitbar(0, wbh, 'starting...');
    set(wbh, 'Name', ['Execution ' int2str(I)]);

    % utiliser DSATUR pour trouver K initial
    dsol = dsatur(prblm.N, prblm.adj);
    K = max(dsol);

    disp([ 'DSATUR a trouvé ' int2str(K) ' couleurs'])

    % éliminer l'une des couleurs de dsol
    dsol(dsol == K) = K-1;
    K = K-1;

    prblm.dsol = dsol;
    prblm.K = K;

    improvingK = 1;

    while improvingK
        disp(['Chercher une ' int2str(prblm.K) ' coloration with dsol fit: ' int2str(FitnessI(prblm.dsol)) ]);
        improvingK = 0;
        [fit, sol, iter, t, lbests, gbests] = hais(popSize, prblm.K, Nc, Nm, r, S, MaxIter);
        if (fit == 0 && prblm.K > minK) % a trouvé une coloration
            % eliminer l'une des couleurs aléatoirement 
            numv = sum(sol == prblm.K);
            sol(sol == prblm.K) = randi(prblm.K-1,1,numv); 
            prblm.K = prblm.K - 1; % voir si on peut trouver une (K-1)-coloration
            prblm.dsol = sol;
            improvingK = 1;
        end
    end
    
    fits(I) = fit;
    iters(I) = iter;
    ts(I) = t;
    
    disp(['Execution ' int2str(I) ' best fit : ' int2str(min(fit)) ' best iter : ' int2str(iter) ' time : ' int2str(t)])
end

beep
close(wbh);

disp(['min : ' int2str(min(fits)) ' max : ' int2str(max(fits)) ' mean : ' num2str(mean(fits))]);

if (draw == 1)
    x = 1:MaxIter;
    plot(x, gbests, x, lbests);
end
end
