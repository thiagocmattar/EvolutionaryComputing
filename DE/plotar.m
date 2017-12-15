
function plotar(fobj,lb,ub,g,P,jP)
% fobj = handle com o nome da funcao objetivo a ser minimizada
% Ex. fobj = @peaks
% lb = vetor de limites inferiores para as variaveis de decisao
% ub = vetor de limites inferiores para as variaveis de decisao
% Ex.: lb = [-2 -2] e ub = [2 2]
% g = geracao atual
% P = matriz P de solucoes candidatas; cada indivíduo ocupa uma coluna de P
% Ex. para N = 8 (individuos) e n = 2 (variaveis de otimizacao)  
%P = [1.2589   -1.4921    0.5294   -0.8860    1.8300   -1.3695    1.8287    1.2011   
%    1.6232    1.6535   -1.6098    0.1875    1.8596    1.8824   -0.0585   -1.4325]
% jP = vetor contendo os valores de fitness para todos os individuos de P
% Ex. jP = [1.9132    0.6394   -5.7512   -1.4110    0.3097    0.9379    2.0521]     

    s = length(lb);

    if (s == 2),
        [x,y] = meshgrid (lb(1):1/2:ub(1), lb(2):1/2:ub(2));    
        z = eval_matrix(fobj,x,y);
        
        figure(1)
        contour(x,y,z);

        hold on    
        plot(P(1,:), P(2,:), 'k*');
        title('Algoritmo Diferencial Evolutivo')
        xlabel('x_1')
        ylabel('x_2')
        grid on
        hold off
    end

    % Imprime os seguintes resultados a cada iteracao:
    % - menor valor de fitness: f(x)
    % - melhor solucao: x = [ x(1) , x(2) ]
    % - geracao atual: g
    [opt,iopt]  = min(jP);
    fprintf(1, 'f(x) = ');
    fprintf(1, '%+6.4f  ', opt);
    fprintf(1, '\t x = [');
    fprintf(1, '%+6.4f  ', P(:,iopt)');
    fprintf(1, '\b\b]; \t g = %d\n', g);

    pause(0.5);

end

function z = eval_matrix(fobj,x,y)

    [u,v] = size(x);
    z = zeros(u,v);

    for i = 1:u
        for j = 1:v
            z(i,j) = feval(fobj,[x(i,j) y(i,j)]);
        end
    end

end
