function r = randperm2(n)
p = 1 : n;
r = zeros(1,2);

ii = ceil(rand * n);
r(1) = p(ii);
p(ii) = p(n);

ii = ceil(rand * (n-1));
r(2) = p(ii);

end
