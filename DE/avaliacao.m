function jX = avaliacao(fobj,X)
% retorna o fitness de todos os individuos da Matriz X de acordo com a
% funcao objetivo fobj
    
    N  = size(X,1);
    jX = zeros(N,1);

    for i = 1:N
        jX(i) = feval(fobj,X(i,:));
    end
    
end