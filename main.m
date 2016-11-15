clc;
clear;
close all;

%LOAD DATA
cities = csvread('berlin52.csv'); %rename the file name
city.x = cities(:,1)';
city.y = cities(:,2)';

%DISTANCE MATRIX
D = round(squareform(pdist(cities)));

%INITIALIZATION
n = size(cities,1);
maxCycle = 3000;
berlin52 = 7542;
ei51 = 426;
bks = berlin52; %best known solution ei51: 426, berlin52: 7542

%PHEROMONE MATRIX INITIALIZATION
tau0 = 1/(n*bks);
tau = tau0 * ones(n, n);
tau(eye(size(tau))~=0) = 0;
eta = 1./D;

%CONSTANTS
alpha = 0.1;
beta = 2;
rho = 0.1;
Q = 1;

%ANT
ant.Tabu = [];
ant.L = [];
nAnts = 10; %number of ants
ants = repmat(ant, nAnts, 1); %initializatioin of n ants


%MATRIX FOR STORING BEST SOLUTION OF EACH ITERATION
%bestSolutions = zeros(maxCycle,1);
%bestCurrent = ant;
bestLocalAnts = repmat(ant, maxCycle,1);
bestGlobalAnts = repmat(ant, maxCycle,1);
bestGlobalAnts(1).L = inf;

%BEST ANT (GLOBALLY)
bestAnt.L = inf;

%ACS
q0 = 0.9;

startCities = StartCity(cities,nAnts);
%Main Iteration
for t=1:maxCycle
    %Loop of Ants
    %startCities = zeros(nAnts,1);
    for k=1:nAnts
        
        %startCities(k,1) = StartCity(startCities,n);
        ants(k).Tabu = startCities(k);               
        %ants(k).Tabu = k;
        for l=2:n
            currentCity = ants(k).Tabu(end);
            unVisitedCity = setdiff(1:n,ants(k).Tabu);
            p=tau(currentCity,unVisitedCity) .* eta(currentCity,unVisitedCity).^beta;          
                       
            q = rand();
            
            if q <= q0 %exploitation
                j = exploit(p, unVisitedCity);
            else %exploration
                j = explore(p, unVisitedCity);
            end                        
            
            ants(k).Tabu = [ants(k).Tabu j];      
            
            %local update
            tau(currentCity,j) = ((1-rho)*tau(currentCity,j)) + (rho*tau0);
            tau(j,currentCity) = tau(currentCity,j);
        end
        
        %LENGTH OF TOUR                    
        ants(k).L = tourLength(D,ants(k),n);    

    end
    %Best solution of current iteration
    bestLocalAnts(t) = localBest(ants);
    
    %Best Global
    if bestLocalAnts(t).L < bestAnt.L
        bestAnt = bestLocalAnts(t);
        bestGlobalAnts(t) = bestAnt;
    else
        if t - 1 > 0
            bestGlobalAnts(t) = bestGlobalAnts(t-1);
        end
    end        
    
    %global update
    bestTabuList = [bestLocalAnts(t).Tabu bestLocalAnts(t).Tabu(1)];
    for l=1:n
        i = bestTabuList(l);
        j = bestTabuList(l+1);
        tau(i,j) = ((1-alpha) * tau(i,j)) + (alpha * (1 / bestLocalAnts(t).L));
        tau(j,i) = tau(i,j);
    end       
    
    
    disp(['Iteration = ' num2str(t) ' Best Global = ' num2str(bestGlobalAnts(t).L) ' Best Local: ' num2str(bestLocalAnts(t).L)]);
    
%     figure(1);
%     PlotTravel(city, ants(k).Tabu);
%     pause(0.01);
end


%results
figure(2);
best = zeros( size(bestGlobalAnts,1) , 1 );
for i = 1:size(bestGlobalAnts,1)
    best(i) = bestGlobalAnts(i).L;
end
plot(best, 'LineWidth', 3);
xlabel('Number of Iterations');
ylabel('Best Cost');
grid on;
