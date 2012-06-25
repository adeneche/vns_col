function [colors, inc] = loadColors(fileName, vertices, colors, inc)

fid = fopen(fileName, 'r');
fgetl(fid);
cols = fscanf(fid, '%d', [2 length(vertices)]);
cols = cols(2,:);

fclose(fid);

cols = cols + inc + 1;

colors(vertices) = cols;
inc = max(colors);

end