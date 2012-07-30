function [ bestFit, sol, numEvals ] = AIS2( popSize, numColors, Nc, Nm, r, S, MaxEval )

global prblm;

bestFit = intmax;
sol = [];

P= initialisation (popSize,prblm.N, numColors);
Fp= Fitness (P);
Rp= calculerang(Fp);

numEvals = popSize;

P = P(Rp,:); % trier la population selon son affinité
Fp= Fp(Rp);


msglen = 0;
nIt = 0;
while bestFit > 0 && numEvals < MaxEval
    nIt = nIt + 1;
    
    % affichage à la ts
    c = zeros(Nc, prblm.N);
    Fc = zeros(Nc, 1);
    ic = 1;
    
    for j= 1: popSize
        ab= P( j,:);
        
        if j < popSize
            nc= nombreclones(popSize, Nc, r, j);
        else
            nc = Nc - ic +1;
        end
        numm = nombremutations(popSize, Nm, j, Fp(j));
        
        for i=1:nc
            [clone]= hypermutation (ab, numm);
            c(ic,:) = clone;
            Fc(ic) = FitnessI(clone);
            ic = ic + 1;
        end
    end
    
    numEvals = numEvals + Nc;
    
    % merge pop and clones
    Np = [P; c];
    Fn = [Fp; Fc];
    [P, Fp] = Select (Fn,Np,S,popSize);
    
    Rp= calculerang(Fp);
    P = P(Rp,:);
    Fp = Fp(Rp);
    
    if (Fp(1) < bestFit)
        bestFit = Fp(1);
        sol = P(1,:);
    end
    
    if (bestFit == 0)
        msg = sprintf('iti, evals: %i\n', nIt, numEvals);
    else%if (mod(nIt, 1000) == 0)
        msg = sprintf('it%i, evals: %i, best: %i\n', nIt, numEvals, bestFit);
    end
    fprintf(repmat('\b',1,msglen));
    fprintf(msg);
    msglen=numel(msg);
end

fprintf(repmat('\b',1,msglen)); % supprimer l'output de cette execution

end

