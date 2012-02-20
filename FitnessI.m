function [ F ] = FitnessI( ind )
%FitnessI calcule la fitness d'un individu pour le N-queens problem

M = size(ind, 2); % nombre de colonnes
% set left and right diagonal counters to 0
leftd = zeros(2*M, 1);
rightd = zeros(2*M, 1);

for i= 1:M
    leftd(i + ind(i)) = leftd(i + ind(i)) + 1;
    rightd(M-i + ind(i)) = rightd(M-i + ind(i)) + 1;
end

sum = 0;
for i = 1:(2*M-1)
    counter = 0;
    if (leftd(i) > 1)
%        counter = counter + leftd(i)-1;
        counter = counter + 1;
    end
    if (rightd(i) > 1)
%        counter = counter + rightd(i)-1;
        counter = counter + 1;
    end
    %sum = sum + counter / (M-abs(i-M));
    sum = sum + counter;
end

F = sum;
end

