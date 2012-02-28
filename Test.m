function [  ] = Test( hais, numExe, N, M, NcRatio, S, pr, MaxIter, draw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global wbh;
wbh = waitbar(0,'Initializing waitbar...');

disp(['Executing ' func2str(hais)]);
fits = [];
iters = [];
ts= [];

if (draw == 1)
    numExe = 1;
end

for I = 1:numExe
    waitbar(0, wbh, ['starting...']);
    set(wbh, 'Name', ['Execution ' int2str(I)]);

    [fit, iter, t, lbests, gbests] = hais(N, M, NcRatio, S, pr, MaxIter);
    
    fits = [fits; fit];
    iters = [iters; iter];
    ts = [ts; t];
    
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
