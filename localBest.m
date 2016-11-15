function ant = localBest(ants)
    bestCost = inf;
    n = size(ants,1);
    for i=1:n
        if ants(i).L < bestCost
            bestCost = ants(i).L;
            ant = ants(i);
        end
    end
end