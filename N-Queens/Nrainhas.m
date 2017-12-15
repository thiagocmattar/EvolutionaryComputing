clear all; clc;

% N-RAINHAS
%
% Tabuleiro NxN
% Fun��o objetivo: APTID�O (n� de xeques)
%
% Espa�o de busca
%
% Perguntas
% 1. Como representar uma solu��o? ok
% 2. Como ser�o os operadores de varia��o (crossover e muta��o)?
% 3. Como ser� o procedimento de sele��o dos pais?
% 4. Como ser� o procedimento de sele��o dos sobreviventes?

%ENTREGAR NO RELAT�RIO VARIA��O DA CONVERG�NCIA COM DIMENS�O DO PROBLEMA
%E AJUSTE DOS PAR�METROS

%DEFINE N
N=8;

%CROSSOVER PROBABILITY
pc=1;
n_parentsslc = 5;

%MUTATION PROBABILITY
pm=0.8;

%POPULATION SIZE
P=50;

%NUMBER OF GENERATIONS
gen=1000;

%==============ALGORITHM

POP=zeros(P,N);
for i=1:P
    POP(i,:)=randperm(N);
end

iteration=1;
avg=zeros(1,gen);
fitness=zeros(P,1);

%Resultados por gera��o
best_fitness=zeros(gen,1);
mean_fitness=zeros(gen,1);
worst_fitness=zeros(gen,1);

for i=1:P
    fitness(i)=fitness_nq(POP(i,:));
end

while iteration<=gen
    %1. Parent selection
    
    %Sele��o aleat�ria de (n_parentsslc) e avalia��o
    parents_idx=randperm(P,n_parentsslc);
    fitness_parents = zeros(n_parentsslc,1);
    for i=1:length(parents_idx)
        fitness_parents(i)=fitness_nq(POP(parents_idx(i),:));
    end
    
    %Ordena��o do vetor e sele��o dos dois mais adaptados
    [~,aux]=sort(fitness_parents);
    parents = zeros(2,N);
    parents(1,:) = POP(parents_idx(aux(1)),:);
    parents(2,:) = POP(parents_idx(aux(2)),:);
    
    %2. Crossover
    offspring = CutAndCrossfill_Crossover(parents);
    
    %3. Mutation
    if(randperm(100,1)<(100*pm))
        idx1 = randperm(N,1);
        idx2 = randperm(N,1);
        aux=offspring(1,idx2);
        offspring(1,idx2)=offspring(1,idx1);
        offspring(1,idx1)=aux;
    end
    offspring(1,:);
    if(randperm(100,1)<(100*pm))
        idx1 = randperm(N,1);
        idx2 = randperm(N,1);
        aux=offspring(2,idx2);
        offspring(2,idx2)=offspring(2,idx1);
        offspring(2,idx1)=aux;
    end
    
    %Concatenando filhos � popula��o
    POP = [POP
        offspring];
        
    %4. Survival selection
    %Avalia��o do custo
    fitness=zeros(P+2,1);
    for i=1:(P+2)
        fitness(i)=fitness_nq(POP(i,:));
    end
    %Sele��o dos 30 mais aptos
    [fitness_value,fitness_idx] = sort(fitness);
    POP = POP(fitness_idx(1:P),:);
    %POP = POP(randperm(P),:);
    
    %Avalia melhor resultado
    best_fitness(iteration) = min(fitness);
    mean_fitness(iteration) = mean(fitness);
    worst_fitness(iteration) = max(fitness);
    
    iteration=iteration+1;
    
    out=['Iteration ' num2str(iteration)];
    fprintf('\n %s',out);
end

figure(1)
plot(mean_fitness,'r-','LineWidth',2); hold on;
plot(best_fitness,'b.-','LineWidth',2); 
legend('Aptid�o m�dia','Melhor aptid�o');
title('Aptid�o por gera��es');
xlabel('Gera��o');
ylabel('Aptid�o');

