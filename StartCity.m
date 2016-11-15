%function j = StartCity(startCities,n)
function startCities = StartCity(cities, n)

    startCities = zeros(n,1);
    for i=1:n
        flag = 1;
        while flag == 1
            r = randi(size(cities,1));
            if any(startCities == r) 
                
            else
                startCities(i) = r;
                flag = 0;
            end
        end
    end
%     flag = 1;
%     while flag
%         startPosition = randi(n);
%         if any(startCities == startPosition)
% 
%         else
% %             j = randi(n);       
%             j = 1;
%             flag = 0;
%         end
%     end
end