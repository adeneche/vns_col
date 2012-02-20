function [ F ] = FitnessI_opt( ind )
%FitnessI calcule la fitness d'un individu pour le N-queens problem

M = size(ind, 2); % nombre de colonnes
% set left and right diagonal counters to 0
leftd = zeros(2*M, 1);
rightd = zeros(2*M, 1);

for i= 1:M
    leftd(i + ind(i)) = leftd(i + ind(i)) + 1;
    rightd(M-i + ind(i)) = rightd(M-i + ind(i)) + 1;
end

F = sum(leftd > 1)+sum(rightd > 1);

end

