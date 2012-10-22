function node = getRandomChainNode(sol, nextClass, conflicting, blacklist)
% function node = getRandomChainNode(sol, nextClass, conflicting, blacklist)
%
% Advanced method to get a random conflicting node:
% renvoit, si possible, le nth (n choisi aléatoirement) vertex qui est
% conflicting, not blacklisted et de la même classe de couleur que
% 'nextClass'
% si nextClass n'est pas définie ou qu'un tel node n'exite pas renvoi,
% si possible, l nth (n choisi aléatoirement) vertex qui est
% conflicting et not blacklisted.

% Color class defined
if (nextClass ~= -1)
    % count conflicting nodes in nextClass color class
    % cc = countColorConflicting(sol, nC, nextClass, conflicting, blacklist);
    temp = (sol == nextClass) & conflicting & ~blacklist;
    cc = sum(temp);
    if (cc > 0) % s'il y a des conflits dans la color class nextClass
        % renvoyer le nth node qui est (color==nextClass, conflicting,
        % ~blacklist)
        nth = randi(cc);
        inds = find(temp);
        node = inds(nth);
        return;
    end
end

% If the search end with unsuccess then try to find both conflicting and not
% blacklisted node with undefined color
temp = conflicting & ~blacklist;
cc = sum(temp);
if (cc > 0) % s'il y a des conflits non blacklisted
    % renvoyer le nth node qui est (conflicting, ~blacklist)
    nth = randi(cc);
    inds = find(temp);
    node = inds(nth);
    return;
end

% there aren't available nodes, return to the caller that the chain can't
% continue
node = -1;

end