function [argmax, argmin] = Extremos(p)
% Regresa los argumentos en los que un polinomio tiene un extremo (máximo o
% mínimo) y los clasifica dependiendo el caso.
%   p es el vector de coeficientes del polinomio 

dp = DifP(p); % (Coeficientes) primera derivada de p
d2p = DifP(dp); % (Coeficientes) segunda derivada de p

ceros = sort(roots(dp)); % Puntos críticos: p'(x) = 0

n = length(ceros); % Número de puntos críticos
argmax = []; % Vector de argumentos maximizantes
argmin = []; % Vector de argumentos minimizantes

for i=1:n % Para cada punto crítico de p:
    if polyval(d2p,ceros(i)) < 0
        % Si p''(x) < 0, x es un máximo local 
        argmax = [argmax, ceros(i)]; 
    elseif polyval(d2p, ceros(i)) > 0
        % Si p''(x) > 0, x es un mínimo local
        argmin = [argmin, ceros(i)];
    end
end

return
end
