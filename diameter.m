function diam = diameter(M)
% left limit
l_limit = min(M(:,1));

%right limit
r_limit = max(M(:,1));

diam = abs(r_limit - l_limit);

end