function [P] = InterpolacionLagrange(x, y)
% Esta es una función que regresa un arreglo P con los coeficientes del
% polinomio de Lagrange que pasa por todos los puntos (x,y) dados. Además
% regresa una matriz L con los coeficientes de los polinomios que se
% utilizan para crear el polinomio de Lagrange.
%   'x' y 'y' deben ser vectores fila.
%   'x' contiene los valores de x para los que f(x) es conocido
%   'y' contiene los valores f(x) correspondientes.

n = length(x); % número de nodos

if ~(n==length(y)) % Verificar que los vectores tengan la misma dimensión
    P ='Error: Los arreglos deben tener la misma dimensión';
    return
end
% La matriz L contendrá los coeficientes de los polinomios con los que
% vamos a intrapolar. Cada fila corresponderá a un polinomio:
L=zeros(n);

for i=1:n
    % Creamos una variable para hacerle cambios a x sin perder info
    xaux = x;
    % Como cada polinomio tiene todos los nodos menos el que le corresponde
    % como raíces, eliminamos esa raíz de nuestro arreglo xaux:
    xaux(i)=[];
    % Ahora guardamos en una fila de la matriz los coeficientes del
    % polinomio que tiene como raíces los valores xaux:
    L(i,:) = poly(xaux);
    % Finalmente normalizamos su valor para que sea 1 en x(i):
    L(i,:) = L(i,:)./polyval(L(i,:), x(i));
end

P = y*L;
return
end