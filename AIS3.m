function [ bestFit, bestIter, T, lbests, gbests ] = AIS3( N, M, NcRatio, S, pr, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh;

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

Nc = round(N*NcRatio);

tic;
iter = 1; % nombre d'iterations
while ~conditionarret(Fp, MinF, iter, MaxIter)
    if (mod(iter, 5)==0)  
        waitbar(iter/MaxIter, wbh, [int2str(iter) ' iterations (' int2str(bestFit) ')']);
    end

    for j= 1: N
        ab= P( j,:) ;
        fab=Fp(j);

        nc= nombreclones(N, Nc, j);
        c = zeros(nc+1, M); 
        Fc = zeros(nc+1, 1);

        leftd = zeros(2*M, 1);
        rightd = zeros(2*M, 1);
        for i= 1:M
            leftd(i + ab(i)) = leftd(i + ab(i)) + 1;
            rightd(M-i + ab(i)) = rightd(M-i + ab(i)) + 1;
        end
       
        for i=1:nc
            [clone fc]= hypermutation3 (ab, leftd, rightd);
            c(i,:) = clone;
            Fc(i) = fc;
        end
        
        c(nc+1, :) = ab;
        Fc(nc+1) = fab;
        
        [p, fp] = Select(Fc, c, S, pr, 1);
        P(j,:) = p;
        Fp(j) = fp;
    end
    
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

