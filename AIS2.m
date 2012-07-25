function [ bestFit, bestSol, bestIter, T, lbests, gbests ] = AIS2( N, K, Nc, Nm, r, S, MaxIter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global wbh prblm;

bestFit = intmax;
bestIter = intmax;
bestSol = [];

lbests = zeros(MaxIter, 1);
gbests = zeros(MaxIter, 1);

P= initialisation (N,prblm.N, K);
Fp= Fitness (P);
Rp= calculerang(Fp);

P = P(Rp,:); % trier la population selon son affinité
Fp= Fp(Rp);

tic;
iter = 1; % nombre d'iterations
lastImproved = 0;

numdblsP = 0;
numdblsC = 0;

c = [];

while ~conditionarret(Fp, prblm.minF, iter, lastImproved, MaxIter)
    if (mod(iter, 5)==0)  
        waitbar(lastImproved/MaxIter, wbh, [int2str(iter) ' iters(' num2str(bestFit) ') min(' int2str(min(Fp)) ') mean(' int2str(mean(Fp)) ') std(' int2str(std(Fp)) ') DblsP(' int2str(numdblsP) ') DblsC(' int2str(numdblsC) ')']);
    end
    
    c = zeros(Nc, prblm.N);
    Fc = zeros(Nc, 1);
    ic = 1;
    
    for j= 1: N
        ab= P( j,:);

        nc= nombreclones(N, Nc, r, j);
        numm = nombremutations(N, Nm, j, Fp(j));
        
        for i=1:nc
            [clone]= hypermutation (ab, numm);
            %[clone]= hypermutation2 (ab);
            c(ic,:) = clone;
            Fc(ic) = FitnessI(clone);
            ic = ic + 1;
        end
    end
    
    [U, I, J] = unique(c, 'rows'); % identifie les anticorps non dbl
    [numdblsC, ~] = size(U);
    numdblsC = size(c, 1) - numdblsC;
    
    % enlever les clones en double
    % c = U;
    % Fc = Fc(I);
    
    Np = [P; c];
    Fn = [Fp; Fc];
%     Np = c;
%     Fn = Fc;
    [P, Fp] = Select (Fn,Np,S,N);

    Rp= calculerang(Fp);
    P = P(Rp,:);
    Fp = Fp(Rp);

    
    if (Fp(1) < bestFit) 
        bestFit = Fp(1);
        bestIter = iter;
        bestSol = P(1, :);
        lastImproved = 0;
    else
%         if (Fp(1) > bestFit)
%             P = [bestSol; P(1:end-1, :)]; % inserer bestSol à la place du worst
%         end
        lastImproved = lastImproved + 1;
    end

    [U] = unique(P, 'rows'); % identifie les anticorps non dbl
    [numdblsP, ~] = size(U);
    numdblsP = N - numdblsP;
    
    lbests(iter) = Fp(1);
    gbests(iter) = bestFit;
    iter = iter + 1;
end

T = toc;
%bestFit2 = FitnessI(P(1,:));

end

