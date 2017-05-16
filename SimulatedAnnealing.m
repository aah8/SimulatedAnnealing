%simulated annealing

clc;
clear;
close all;

%% problem definition
model = CreateModel1(); %creates the model of the problem

nVar = model.nVar; %indicates number of decision variables
VarSize = [1 nVar] %size of the decision variable matrix

CostFunction = @(q) MyCost(q,model); %cost function


%% SA parameters
MaxIt=100; %maximum number of outer iterations (temperature - means we will decrease the temperature in 100 steps)
MaxIt2=10; %maximum number of inner iterations (evaluate 10 solutions at each temperature)

%initial temperature
T0=10; %could be any number
alpha=0.98 %temperature damping rate


%% Initialization

x.Position=CreateRandomSolution1(model);
[x.Cost x.Sol]=CostFunction(x.Position);

% Update the best solution ever found
BestSol=x;

%Array to hold best cost values
BestCost=zeros(MaxIt,1);

%Set initial temperature
T=T0;

%% SA Main Loop

for it=1:MaxIt
   for it2=1:MaxIt2
      %create neighbor (new permutation)
      xnew.Position=CreateNeighbor1(x.Position);
      [xnew.Cost xnew.Sol]=CostFunction(xnew.Position); %get cost and solution of neighbor
      
      if xnew.Cost <= x.Cost
          %xnew is better, so replace the old one by the new one
          x=xnew;
      else
          %xnew is not better, so it is accepted conditionally
          delta = xnew.Cost - x.Cost;
          p = exp(-delta/T);
          
          if rand <= p %if random number is less than the probability 
              x=xnew; %accept the new one (even though it's not good)
          end
          
      end
      
      %update the best solution
      if x.Cost <= BestSol.Cost
          BestSol = x;
      end
   
   end
   
   %reduce the temperature
   T=alpha*T;
   
   %store the best cost
   BestCost(it) = BestSol.Cost;
   
   %display iteration information
   disp(['Iteration ' num2str(it) ': Best cost = ' num2str(BestCost(it))]);
   
   
    % Plot Solution
    pause(0.1);
    figure(1);
    PlotSolution(BestSol.Sol,model);
end

%Results
figure;
plot(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');