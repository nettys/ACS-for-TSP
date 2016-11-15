function city = explore(p, unVisitedCity)
    %p = tau(currentCity,unVisitedCity) .* (eta(currentCity,unVisitedCity).^beta);
    p = p ./ sum(p);
    
    if sum(p) ~= 0
        p = p./sum(p);
    else
        p = ones(length(p),1)/length(p);
    end
    
    r = rand();
    c = cumsum(p);
    city = unVisitedCity(find(r<=c,1)); 
end