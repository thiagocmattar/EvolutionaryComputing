function [F, varargout] = rastrigin (x, varargin)

    x = x(:);

    %
    %   Rastrigin: f = \sum_{i=1}^{n} (x_i^2 - 10 \cos(2 \pi x_i))
    %

    Q = eye(length(x)); 
    X = Q*x;
    n = length(X);

    F = 0;
    for i = 1:n
       F = F + X(i)^2 - 10*cos(2*pi*X(i));
    end

    %
    %   ou, uma formulacao diferente...
    %

    % A = [1 0; 0 4];
    % F = x'*(A')*A*x - 10*[1 1]*cos(2*pi*A*x);  

    varargout(1) = {F};
    varargout(2) = {0};

end