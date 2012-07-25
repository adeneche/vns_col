function [ F ] = Fitness( P )
%Fitness calcule la fitness de tous les individus de la population P

  N = size(P, 1);
  F = zeros(N, 1);
  for i = 1:N
      F(i) = FitnessI(P(i,:));
  end
end

