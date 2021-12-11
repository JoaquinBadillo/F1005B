function [integral] = IntP(p, a, b)
%Calcula la integral definida del polinomio p desde a hasta b
%   p es el arreglo con los coeficientes del polinomio
%   a y b son los límites de integración inferior y superior
%   respectivamente.
n = length(p); % Orden de la integral
g = 1./(n:-1:1); % Coeficientes de la integral
g = [g, 0]; % Incrementamos el orden
p = [p, 0]; % Incrementamos el orden del polinomio
intp = g.*p; % Antiderivada (con C = 0)
integral = polyval(intp, b) - polyval(intp, a);
return
end