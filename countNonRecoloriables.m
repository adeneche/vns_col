function count = countNonRecoloriables(c, colors, adj)

nodes = find(colors == c);

count = 0;
for i = 1:length(nodes)
    if (isempty( nonAdjCols(nodes(i), adj, colors)))
        count = count + 1;
    end
end

end