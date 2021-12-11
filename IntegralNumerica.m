function [integral] = IntegralNumerica(f, a, b, n, g, bool)
% Aproxima el valor de una integral definida con polinomios de Lagrange
%   f es el integrando
%   a es el límite inferior de integración
%   b es el límite superior de integración
%   n es la cantidad de polinomios a utilizar
%   g es el grado de tales polinomios
%   bool es un booleano que determina si queremos graficar

h = (b-a)/n; % distancia subintervalos
h2 = h/g; % distancia subsubintervalos
integral = 0; % integral acumulada
j=0:1:g; % vector loop
if (bool)
    figure
    x=a:0.01:b;
    plot(x, f(x), 'LineWidth', 2);
    title("Integral Numérica")
    xlabel("x")
    ylabel("y")
    hold on;
    % iteramos por cada subintervalo:
    for i=1:n
        xi = a+(i-1)*h; % Valor inicial del subintervalo
        xf = a+h*i; % Valor final del subintervalo
        x = xi + j*h2; % valores de x para la interpolación en el subintervalo
        y = f(x); % valores de y correspondientes
        p = InterpolacionLagrange(x,y); % Interpolacion
        integral = integral + IntP(p, xi, xf); % Integral acumulada
        % gráfica
        t=xi:0.01:xf;
        plot(t, polyval(p, t))
        area(t, polyval(p, t))
        hold on
    end
    hold off
    alpha(0.3)
    return
else
    % bool = false, lo mismo sin graficar
    for i=1:n
        xi = a+(i-1)*h; % Valor inicial del subintervalo
        xf = a+h*i; % Valor final del subintervalo
        x = xi + j*h2; % valores de x por cada subintervalo
        y = f(x); % valores de y correspondientes
        p = InterpolacionLagrange(x,y); % Interpolación
        integral = integral + IntP(p, xi, xf); % Integral acumulada
    end
    return
end
end