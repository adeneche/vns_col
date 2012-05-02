function [  ] = Test( instance, minF, hais, numExe, popSize, NcRatio, S, pr, MaxIter, draw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global wbh prblm

wbh = waitbar(0,'Initializing waitbar...');

disp(['Executing ' func2str(hais)]);

if (draw == 1)
    numExe = 1;
end

%prblm = [];

% load bpp data files
fid = fopen(instance, 'r');
prblm.minF = minF;
prblm.N = fscanf(fid, '%d', [1 1]);
prblm.C = fscanf(fid, '%d', [1 1]);
prblm.W = fscanf(fid, '%d', [1 prblm.N]);
fclose(fid);

fits = zeros(numExe, 1);
iters = zeros(numExe, 1);
ts = zeros(numExe, 1);

for I = 1:numExe
    waitbar(0, wbh, ['starting...']);
    set(wbh, 'Name', ['Execution ' int2str(I)]);

    [fit, iter, t, lbests, gbests] = hais(popSize, prblm.N, NcRatio, S, pr, MaxIter);
    
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
