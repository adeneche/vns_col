function [bestParams, bestUtility] = revac(popsize, bestsize, smooth, rep, maxevals)
% revac: Relevance Estimation and VAlue Calibration
%
% popsize : population size
% bestsize: parent selection size
% smooth  : smoothing coefficient (mutation interval's h)
% rep     : repetitions per vector (num exec per vector)
% maxevals: max num vectors tested

% cette méthode devrait recevoir les intervals des params à investiguer
params = zeros(5,2);
params(1,:) = [10, 15]; % population size (int) (best so far 10)
params(2,:) = [2, 3];    % number of clones multiplier (number) (best so far 2.3)
params(3,:) = [10, 30];   % number of moves per mutation (int) (best so far 14)
params(4,:) = [0, 1];    % r (num clone formula) (number) (best so far 0.41)
params(5,:) = [2, 10];   % tournament selection size (int) (best so far 7)

% générer population initiale aléatoirement, la valeur de chaque paramètre
% est généré aléatoirement de manière uniforme
pop = zeros(popsize, size(params, 1));
pop(:,1) = randi(params(1,:), popsize, 1);
pop(:,2) = rand(popsize, 1)*(params(2,2) - params(2,1)) + params(2,1);
pop(:,3) = randi(params(3,:), popsize, 1);
pop(:,4) = rand(popsize, 1)*(params(4,2) - params(4,1)) + params(4,1);
pop(:,5) = randi(params(5,:), popsize, 1);

% initialisation nécessaire à utility
global prblm

% load bpp data files
[ prblm.adj, prblm.N, prblm.E ] = loadDimacs('DSJC125.1.col');
prblm.NumColors = 5; % optimal solution
prblm.dsol = []; % puisqu'on commence directement par la couleur optimale

utilities = zeros(popsize, 1);
% evaluation initiale: evaluaer l'utility de chaque vector
for v = 1:popsize
    utilities(v) = utility(pop(v,:), rep);
end

nIt = 0;
while nIt < maxevals
    nIt = nIt + 1;
    
    disp(['Iteration ' int2str(nIt)])
    
    % trier la population par utility
    [utilities, I] = sort(utilities);
    pop = pop(I,:);
    
    % parent selection: deterministic, select n (bestsize) best vectors
    % (with highest utility)
    selected = pop(1:bestsize, :);
    
    child = recombination(selected);
    
    mutated = mutation(selected, child, smooth);
    
    % survivor selection: deterministic, the newly generated child always
    % replaces the worst vector in the population
    pop(end, :) = mutated;
    
    % evaluation: the utility of the newly generated child is estimated
    utilities(end,:) = utility(mutated, rep);
end

[utilities, I] = sort(utilities);
pop = pop(I,:);
bestParams = pop(1,:);
bestUtility = utilities(1,:);

end

function mbf = utility(vec, rep)
% utility: evalue l'utility d'un vecteur en executant AIS rep fois
% l'utility calculée est la Mean Best Fitness (MBF), les valeurs les plus
% petites étant les meilleures

global prblm

EAMaxEvals = 5000; % critère d'arrêt pour l'AIS, nombre max d'evaluations

popSize = vec(1);
Nc      = floor(vec(2)*popSize);
Nm      = vec(3);
R       = vec(4);
S       = vec(5);

% lancer AIS avec les params vec et la coloration optimale
mbf = 0;
fprintf([mat2str(vec, 3) ':']);

for r = 1:rep
    msg = sprintf('%i:', r);
    fprintf(msg);
    
    [fit, ~] = AIS2(popSize, prblm.NumColors, Nc, Nm, R, S, EAMaxEvals);
    mbf = mbf + fit;
    
    fprintf(repmat('\b',1,numel(msg)));
end

mbf = mbf / rep;
disp(mbf)

end

function child = recombination(parents)
% recombination: multi-parent crossover operator, uniform scanning:
% . apply to the selected vectors (parents)
% . the ith value in the child (c1,...,ck) is selected from the ith values (x1i,...,xni)
%   of the parents uniform randomly
% . we create one child from the selected n parents
child = zeros(1, 5);
for i = 1:5
    child(i) = randsample(parents(:,i), 1);
end

end

function mutated = mutation(parents, child, smooth)
% mutation: works independently on each parameter i in 2 steps:

mutated = child;

for i = 1:5
    values = parents(:,i);
    values = sort(values);
    
    % indice de child(i) dans les values des parents
    ind = find(values == child(i));
    ind = ind(1);
    
    % . a mutation interval [xai, xbi] is calculated
    interval = zeros(1,2*smooth);
    %  . to define the mutation interval from a given ci value all values x1i,...,xni for this
    %    parameter in the selected n parents are also taken into account
    if (ind >= smooth)
        interval(1:smooth) = values((ind-smooth+1):ind);
    else
        %  . as their are no neighbors beyond the upper and lower limits of the domain, we extend
        %    it by mirroring the parent values as well as the mutated values at the limits
        part1 = ind;
        interval(1:ind) = values(1:ind);
        part2 = smooth-part1;
        interval((ind+1):smooth) = values(1:part2);
    end
    numParents = length(values);
    if (ind+smooth-1 <= numParents)
        interval((smooth+1):end) = values(ind:(ind+smooth-1));
    else
        %  . as their are no neighbors beyond the upper and lower limits of the domain, we extend
        %    it by mirroring the parent values as well as the mutated values at the limits
        part1 = numParents - ind + 1;
        interval((smooth+1):(smooth+1+part1)) = values(ind:end);
        part2 = smooth - part1;
        interval((smooth+part1+2):2*smooth) = values((end-part2+1):end);
    end
    %  . sort them in increasing order
    %  . xai = h-th lower neighbor of ci
    xa = min(interval);
    %  . xbi = h-th upper neighbor of ci
    xb = max(interval);
    
    % . a random value ci' is chosen randomly from this interval to be mutated,
    if (i == 2 || i == 4)
        mutated(i) = rand*(xb-xa)+xa;
    else
        mutated(i) = floor(rand*(xb-xa)+xa);
    end
end

end