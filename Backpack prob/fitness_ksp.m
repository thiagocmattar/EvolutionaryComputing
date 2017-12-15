function [f]=fitness_ksp(solution, values, weights, cap)
% returns the fitness for a given binary chromossome (knapsack configuration)
% values = vector containing the correponding values for all objects
% weights = vector containing the corresponding weights for all objects 
% cap = capacity of the knapsack

    % penalization factor
    rho = max(values./weights);

    totalBenefit = sum(solution.*values);

    totalWeight = sum(solution.*weights);

    if totalWeight > cap,
        f = totalBenefit - rho * (totalWeight - cap);
    else
        f = totalBenefit;
    end

end