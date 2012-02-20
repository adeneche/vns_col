function [  ] = Test2( numExe, N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh;


fits = zeros(numExe,1);
iters = zeros(numExe,1);
ts= zeros(numExe,1);
numEvals = zeros(numExe,1);

wbh = waitbar(0,'Initializing waitbar...');

for I = 1:numExe
    %['iteration : ' int2str(I)]
    waitbar(0, wbh, ['starting...']);
    set(wbh, 'Name', ['Execution ' int2str(I)]);
    
    [fit, iter, t, numE] = AIS2(N, M, NcRatio, S, pr, MaxIter);
    fits(I) = fit;
    iters(I) = iter;
    ts(I) = t;
    numEvals(I) = numE;
    disp(['Execution ' int2Str(I) ' best fit : ' int2str(min(fit)) ' best iter : ' int2str(iter) ' num evals : ' int2str(numE)])
end

beep
close(wbh);

disp(['Fitness  : min ' int2str(min(fits)) ', max ' int2str(max(fits)) ', moy ' int2str(mean(fits))]);
disp(['Num Eval : min ' int2str(min(numEvals)) ', max ' int2str(max(numEvals)) ', moy ' int2str(mean(numEvals))]);

end
