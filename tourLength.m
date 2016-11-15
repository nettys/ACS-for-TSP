function L = tourLength(D, ant, n)
    L = 0;
    tabu = [ant.Tabu ant.Tabu(1)];
    for i=1:n            
        L = L + D(tabu(i), tabu(i+1));
    end  
end