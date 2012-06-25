function count = countCutEdges(adj, ndx)

N = size(adj,1); % num vertices

count = 0;
for i=1:N
    for j=i+1:N
        if (adj(i,j) && ndx(i) ~= ndx(j))
            count = count + 1;
        end
    end
end

% count = count/2;

end