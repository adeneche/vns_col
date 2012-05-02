function [ bestFit, bestIter, T, lbests, gbests ] = AIS1( N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh prblm;

bestFit = intmax;
bestIter = intmax;

lbests = zeros(MaxIter, 1);
gbests = zeros(MaxIter, 1);

P= initialisationNQ (N,M);
Fp= Fitness (P);
Rp= calculerang(Fp);

P = P(Rp,:); % trier la population selon son affinit�
Fp= Fp(Rp);

firstI = Inertia(P);

Nc = round(N*NcRatio);

tic;
iter = 1; % nombre d'iterations
while ~conditionarret(Fp, prblm.minF, iter, MaxIter)
    if (mod(iter, 5)==0)  
        I = Inertia(P)/firstI;
        waitbar(iter/MaxIter, wbh, [int2str(iter) ' iterations (' int2str(bestFit) ') inertia (' num2str(I) ')']);
    end
    
    c = zeros(Nc, M);
    Fc = zeros(Nc, 1);
    ic = 1;
    
    for j= 1: N
        ab= P( j,:) ;
        nc= nombreclones(N, Nc, j);
         
        for i=1:nc
            [clone fc]= hypermutation (ab);
            c(ic,:) = clone;
            Fc(ic) = fc;
            ic = ic + 1;
        end
    end
        
    [P, Fp] = Select(Fc,c,S,pr,N);

    Rp= calculerang(Fp);
    P = P(Rp,:);
    Fp = Fp(Rp);
    
    if (Fp(1) < bestFit) 
        bestFit = Fp(1);
        bestIter = iter;
    end
    
    lbests(iter) = Fp(1);
    gbests(iter) = bestFit;
    iter = iter + 1;
end

T = toc;
end

