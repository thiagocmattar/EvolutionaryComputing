%OTIMIZA��O - COMPUTA��O EVOLUCION�RIA
%Problema da Mochila

%%
%DEFINI��O DO PROBLEMA 
clear; clc;

nItems = 8; %N�mero de itens;
v = [5 8 7 6 9 5 4 3]; %Valores;
w = [10 18 12 14 13 11 8 6]; %Pesos;
cap = 35; %Capacidade
pCrossover = 0.6; %Prob de cruzamento
pMutation = 0.001; %Prob de muta��o
popsize = 30; %Tamanho da popula��o
numChildren = popsize; %N�mero de filhos
maxGenerations = 200; %M�ximo de gera��es

%Defini��o da popula��o
POP = randi([0 1],[popsize 8]);

%Avalia��o de candidatos 
best_fitness = zeros(1, maxGenerations);
mean_fitness = zeros(1, maxGenerations);

pop_fitness = zeros(popsize,1);
%Avalia��o da popula��o
for i=1:popsize
   pop_fitness(i) = fitness_ksp(POP(i,:),v,w,cap); 
end


%%
%LOOP PRINCIPAL

for i=1:maxGenerations

   %1. Sele��o dos pais
   fitnessSUM = sum(pop_fitness);
   PSI = pop_fitness / fitnessSUM;
   
   %roleta
   selSpace = cumsum(PSI);   
   unifDist = (1:numChildren)/numChildren;
   aux = 0;
   for j = 1:numChildren
       parents_idx(j)=find((selSpace - ones(numChildren,1)*aux)>0,1);
       aux = aux + 1/numChildren;
   end
   parents=POP(parents_idx,:);
   
   %2. Crossover
   k = 1;
   while((k-1)<numChildren)
       if(rand(1)<pCrossover)   
           cut_idx = randperm(nItems,1);
           aux = parents(k,1:cut_idx);
           parents(k,1:cut_idx) = parents(k+1,1:cut_idx);
           parents(k+1,1:cut_idx) = aux;
       end
       childrens(k,:) = parents(k,:);
       childrens(k+1,:) = parents(k+1,:);
   
       k = k+2;
   end
   
   %3. Muta��o
   for c=1:numChildren
       for gene=nItems
           if(rand(1)<pMutation)
               childrens(c,gene) = 1 - childrens(c,gene);
           end
       end
   end
   
   %4. Sele��o de Sobreviventes
   POP = childrens;
   
   %Avalia��o da popula��o
   for j=1:popsize
      pop_fitness(j) = fitness_ksp(POP(j,:),v,w,cap); 
   end
   
   best_fitness(i) = max(pop_fitness);
   mean_fitness(i) = mean(pop_fitness);
   
end

[~,best_idx]=max(pop_fitness);
POP(best_idx,:)

figure(1)
plot(mean_fitness,'r-o','LineWidth',1,'MarkerSize',2);
hold on;
plot(best_fitness,'k-o','LineWidth',1,'MarkerSize',2);
legend('Aptid�o m�dia','Melhor aptid�o');
ylim([10 22]);
title('Aptid�o por gera��es');
xlabel('Gera��o');
ylabel('Aptid�o');