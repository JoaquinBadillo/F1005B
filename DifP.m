function [derivada] = DifP(p)
% Calcula los coeficientes de la derivada de un polinomio
%   p son los coeficientes del polinomio

n = length(p)-1; % orden de p
p = p(1:n); % reducir orden
k = n:-1:1; % regla del poder

derivada = p.*k; % coeficientes de la derivada
return
end