%OTIMIZA��O - COMPUTA��O EVOLUCION�RIA
%Algoritmo diferencial evolutivo
%Thiago Mattar

function [P,jP] = de(fobj,lb,ub,N)

%   - fobj = funcao objetivo a ser otimizada
%   - lb = vetor contendo os limites superiores das variaveis de decisao
%   - N = tamanho da populacao inicial
%   - Exemplos de uso:
%       [P,jP] = de(@rastrigin,[-2 -2],[2 2],100)
%       [P,jP] = de(@peaks,[-3 -3],[3 3],40)



%Par�metros
g = 1;          %Gera��o atual
gmax = 40;      %M�ximo n�mero de gera��es

c = 0.9;        %Probabilidade de recombina��o
F = 0.9;        %Fator de escala

n = length(lb);

%Popula��o inicial
P = ((repmat(ub(:),1,N)-repmat(lb(:),1,N)).*rand(n,N) + repmat(lb(:),1,N))';

%Defini��o matriz U
U = zeros(N,n);

% Avaliacao das solucoes candidatas
jP = avaliacao(fobj,P);

while(g<=gmax)
    
    Jbest(g) = min(jP);
    Jmed(g) = median(jP);
    
    for i=1:N
        r = randi([1 N],[3 1]);
        %Usar vetor na dire��o na melhor dire��o
        delta = randi([1 n],1);
        for j=1:n
            if(rand(1)<=c || j==delta)
                U(i,j) = P(r(1),j) + F.*(P(r(2),j)-P(r(3),j));
            else
                U(i,j) = P(i,j);
            end
        end
        
        
        dif_vec(i,:) = (P(r(2),:)-P(r(3),:));
        
        %Reflex�o
        for j = 1:n
            if(U(i,j)<lb(j))
                U(i,j) = lb(j);
            elseif(U(i,j)>ub(j))
                U(i,j) = ub(j);
            end
        end
        
        if(feval(fobj,U(i,:))<=feval(fobj,P(i,:)))
            P(i,:) = U(i,:);
        end
    end
        
    % Avaliacao das solucoes candidatas
    jP = avaliacao(fobj,P);
    plotar(fobj,lb,ub,g,P',jP');
    
    %Itera��o
    g = g+1;
end

figure;
plot(Jbest,'k-o','LineWidth',2,'MarkerSize',2);
hold on;
plot(Jmed,'r-o','LineWidth',2,'MarkerSize',2);
legend('Melhor individuo','Individuo m�dio');
title('Algoritmo Diferencial Evolutivo');
xlabel('geracao');
ylabel('f(x) (melhor por geracao)');
grid;

end



