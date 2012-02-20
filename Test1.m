function [  ] = Test1( numExe, N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global wbh;
wbh = waitbar(0,'Initializing waitbar...');

fits = [];
iters = [];
ts= [];
for I = 1:numExe
    waitbar(0, wbh, ['starting...']);
    set(wbh, 'Name', ['Execution ' int2str(I)]);

    [fit, iter, t] = AIS(N, M, NcRatio, S, pr, MaxIter);
    fits = [fits; fit];
    iters = [iters; iter];
    ts = [ts; t];
    
    disp(['Execution ' int2Str(I) ' best fit : ' int2str(min(fit)) ' best iter : ' int2str(iter)])
end

beep
close(wbh);

fits
minFit = min(fits)
maxFit = max(fits)
moyFit = mean(fits)
end
