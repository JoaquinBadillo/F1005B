function [y] = RectaTangente(p,x,t)
%Regresa y grafica la recta tangente a un polinomio p en el punto x en un intervalo
%   p es un arreglo con los coeficientes del polinomio
%   x es un punto
%   t es un arreglo que contiene el punto inicial y final del intervalo
px = polyval(p, x);

dp = DifP(p);
m = polyval(dp, x);

y = @(t) m*(t-x) + px;

plot(t, y(t), "Color",[0 0 1])
return
end