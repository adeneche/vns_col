function saveGraph(fileName, adj, N, E)

fid = fopen(fileName, 'w');
fprintf(fid, 'p edge %d %d\n', N, E);

for i = 1:N-1
    for j=i+1:N
        if (adj(i,j)) 
            fprintf(fid, 'e %d %d\n', i, j);
        end
    end
end

fclose(fid);

end