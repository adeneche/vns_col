function [ adj, N, E ] = loadDimacs(filename)
%loadDimacs: charge un fichier dimacs

fid=fopen(filename, 'r');

% skip comments
c = fscanf(fid, '%c', 1);
while (c == 'c')
fgetl(fid);
c = fscanf(fid, '%c', 1);
end

type = fscanf(fid, '%s', 1);
if (~strcmp(type, 'edge'))
    %error('File type != edge');
    disp(['Warning: type "' type '" != edge'])
end

% taille du problème
psize = fscanf(fid, '%d', [1 2]);
fgetl(fid);

N=psize(1); % nombre de nodes
E=psize(2); % nombre d'edges

% matrice d'adjacence
adj = zeros(N,N);

for i = 1:E
	fscanf(fid, '%c', 1);
	edge = fscanf(fid, '%d', [1 2]);
	adj(edge(1), edge(2))=1;
	adj(edge(2), edge(1))=1;
	fgetl(fid);
end

fclose(fid);

end