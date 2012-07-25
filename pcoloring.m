function pcoloring(instance, numP, numIter)
%function pcoloring(instance, numP)
%
% instance: nom de l'instance à colorier
% numP: nombre de partitions

% charger graphe initial
% adj: matrice d'adjacence
% N: nombre de nodes
% E: nombre de edges
[adj, N, E] = loadDimacs(instance);

% partitioner le graphe
disp('partitioning the graph...')
[ndx, ~, ~]  = grPartition(adj, numP, 30);


for iter = 1:numIter
    colors = zeros(N, 1); % couleurs de tous les nodes
    inc = 0;

    cparts = []; % partition de chaque couleur
    
    % sauver les partitions dans des fichiers 'instance.pi' et lancer la
    % coloration
    disp('saving partitioned graphs...')
    for p = 1:numP
        disp(['coloring partition ' int2str(p) ' ...'])
        % identifier les vertices de la partition
        vertices = find(ndx == p);
        % retrouver le sous graphe de la partition
        [sadj, sN, sE] = subGraph(adj, vertices);
        filename = [ instance '.part' int2str(p) ];
        subgfile = ['instances/' filename];
        saveGraph( subgfile, sadj, sN, sE);
        % color the partition
        [status, ~] = system(['~/Downloads/graphCol/color_tabu ' subgfile ]);
        if (status ~= 0)
            throw(exception([ 'error while coloring partition ' int2str(p)]));
        end
        % load the solution
        solfile = [filename '(best).sol'];
        [colors, inc2] = loadColors(['instances_colored_tabu/' solfile], vertices, colors, inc);
        pnumc = inc2 - inc; % nombre de couleurs trouvées
        cparts = [cparts ones(1, pnumc)*p];
        inc = inc2;
        
        disp(['found ' int2str(pnumc) ' colors'])
    end

    numc = max(colors);

    beep
    disp(['Nombre de couleurs apres le partitionement: ' int2str(numc)])

    % dans chaque partition identifier la couleur qui a le moins de nodes non
    % recoloriables

    % commencer par identifier les nodes non recoloriables
    nreco = zeros(N, 1); % reco(n) = 1 si le node n n'est par recoloriable
    for n = 1:N
        nreco(n) = isempty(nonAdjCols(n, adj, colors));
    end

    % calculer le nombre de nodes non recoloriables pour chaque couleur
    numnrec = zeros(numc, 1);
    for c = 1:numc
        numnrec(c) = sum(nreco(colors == c));
    end

    % TODO: pour chaque couleur recoloriable, la recolorier
    % attention, chaque nodes recolorié nécessite de recalculer numnrec

    % identifier pour chaque partition, la couleur qui a le moins de nodes
    % recoloriables
    selected = zeros(numP, 1); % selected(p) = couleur selected dans la partition p
    for p = 1:numP
        temp = numnrec;
        temp(cparts ~= p) = N+1; % affecter une valeur très grande aux couleurs qui ne font pas partie de la partition
        [mc, ic] = min(temp);
        selected(p) = ic; % indice de la couleur choisie
    end

    % affecter chaque couleur à la partition suivante
    for p = 1:numP
        nodes = colors == selected(p); % nodes de la couleur à déplacer
        % partition cible
        newp = p + 1;
        if (newp == (numP+1))
            newp = 1;
        end

        ndx(nodes) = newp;
    end
end

end
