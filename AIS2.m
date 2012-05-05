function [ bestFit2, bestIter, T, lbests, gbests ] = AIS2( N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh prblm;

MinF = 0;
bestFit = intmax;
bestIter = intmax;

lbests = zeros(MaxIter, 1);
gbests = zeros(MaxIter, 1);

P= initialisationNQ (N,M);
Fp= Fitness (P);
Rp= calculerang(Fp);

P = P(Rp,:); % trier la population selon son affinité
Fp= Fp(Rp);

firstI = Inertia(P);

Nc = round(N*NcRatio);

tic;
iter = 1; % nombre d'iterations
while ~conditionarret(Fp, prblm.minF, iter, MaxIter)
    if (mod(iter, 5)==0)  
        I = Inertia(P)/firstI;
        waitbar(iter/MaxIter, wbh, [int2str(iter) ' iterations (' num2str(bestFit) ')']);
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
    
    Np = [P; c];
    Fn = [Fp; Fc];
    [P, Fp] = Select (Fn,Np,S,pr,N);

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
bestFit2 = Fitness2I(P(1,:));

end

