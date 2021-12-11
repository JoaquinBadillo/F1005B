function [r] = RadioCurvatura(p,a)
%Función que calcula el radio de curvatura de un polinomio p en un punto
%dado o en un conjunto de puntos dados.
%   p es el polinomio
%   a es el conjunto de puntos
dp = DifP(p);
d2p = DifP(dp);

r = power(1+polyval(dp,a).^2, 3/2)./abs(polyval(d2p, a));
return
end