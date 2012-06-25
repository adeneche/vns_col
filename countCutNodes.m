function count = countCutNodes(adj, ndx)

N = size(adj,1); % num vertices

count = 0;
for i=1:N
    iscut = 0;
    j = 1;
    while (~iscut && j <= N)
        iscut = (adj(i,j) && ndx(i) ~= ndx(j));
        j = j+1;
    end
    count = count + iscut;
end

count = count/2;

end