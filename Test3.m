function [  ] = Test3( numExe, N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh;


fits = [];
iters = [];
ts= [];

wbh = waitbar(0,'Initializing waitbar...');

for I = 1:numExe
    %['iteration : ' int2str(I)]
    waitbar(0, wbh, ['starting...']);
    set(wbh, 'Name', ['Execution ' int2str(I)]);
    
    [fit, iter, t] = AIS3(N, M, NcRatio, S, pr, MaxIter);
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
