
function M = reflexao(M,lb,ub)

% Garante que as soluces pertencam aos limites viaveis estabelecidos pelas
% variaveis de decisao

n = size(M,1);

for i = 1:n
    M(i, M(i,:) < lb(i)) = lb(i);
    M(i, M(i,:) > ub(i)) = ub(i);
end

    