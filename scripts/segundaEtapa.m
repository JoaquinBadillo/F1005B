% Script para simular un vehículo en un tramo de una pista de Fórmula 1 y las gradas
% usando un polinomio de grado 3. Considerando la longitud de arco, el
% radio de curvatura, los extremos y las rectas tangentes en una zona
% crítica.

% Autoría:
% Andrea Alexandra Barrón Córdova (A01783126)
% Alina Rosas Macedo (A01252720)
% Almudena Morán Sierra (A01782147)
% Fernanda Cantú Ortega (A01782232)
% Joaquín Badillo Granillo (A01026364)
% Nahomi Daniela Plata Ulate (A01027008)

clc; clear all; close all;

%% INTERPOLACIÓN

% Vectores de coordenadas (x_i, y_i)
x = [300, 1730, 2610, 2800];
y = [2300, 2050, 560, 1200];

% Utilizar módulo de interpolación para determinar el polinomio
P = InterpolacionLagrange(x, y);
disp('Polinomio de Lagrange')
format long
disp(P)
disp('')

%% LONGITUD DE ARCO

% Integrando de la longitud de arco
integrando = @(t) sqrt(1 + polyval(DifP(P),t).^2);

% Booleano para "activar" o "desactivar" gráfica de integral numérica
grafica = 0;

% Longitud de arco usando integración numérica con 10 polinomios de grado 4
s = IntegralNumerica(integrando, 300, 2800, 10, 4, grafica);

% Mostrar por pantalla la longitud de arco
disp('Longitud de arco')
disp(strcat("s = ",string(s), " m"))
disp('')

%% MÁXIMOS Y MÍNIMOS

% Módulo de extremos para encontrar argumentos maxizimantes y minimizantes
[argmax, argmin] = Extremos(P);

% Determinar número de máximos y mínimos
n = length(argmax);
m = length(argmin);

% Mostrar puntos máximos con notación (x,p(x))
disp('Máximos')
for i=1:n
disp(strcat('(', string(argmax(i)), ", ", string(polyval(P, argmax(i))), ')'))
end
disp('')

%Mostrar puntos mínimos con notación (x,p(x))
disp('Mínimos')
for i=1:m
disp(strcat('(', string(argmin(i)), ", ", string(polyval(P, argmin(i))), ')'))
end

%% GRÁFICAS

% Vector de variable independiente para animar
t = 300:25:2800;

% Graficar radio de curvatura en distintos puntos de la curva
figure
set(gcf, 'Position', get(0, 'Screensize'));
for i=1:length(t)
    plot(t(1:i),polyval(P,t(1:i)), "Color",[0 0 0], "LineWidth", 8)
    axis([300 2800 0 4500])
    xlabel("x (m)")
    ylabel("y (m)")
    drawnow
    hold on

    plot(t(1:i),polyval(P,t(1:i)), "Color",[1 1 1], "LineWidth", 1, "LineStyle", "--")
    drawnow
end
hold on

% Marcar los extremos (máximo y mínimo) con * en la gráfica
plot(argmax, polyval(P, argmax), 'g*');
hold on
plot(argmin, polyval(P, argmin), 'g*');
hold on

% Graficar puntos con R < 100 m cerca del máximo local 
tc1 = 865.87:0.1:874.96;
plot(tc1, polyval(P, tc1), 'r.')
hold on

% Tangente al primer punto
p1 = 865.87;
R1 = RectaTangente(P,p1, [p1-200, p1+200]);
hold on

% Graficar puntos con R < 100 m cerca del mínimo local
tc2 = 2421.7:0.1:2430.79;
plot(tc2, polyval(P, tc2), 'r.')
hold on

% Tangente al segundo punto
p2 = 2421.7;
R2 = RectaTangente(P,p2, [p2-200, p2+200]);
hold on

%% GRADAS

% Gradas cerca del máximo

% Recta base de las gradas (agregar distancia de seguridad)
yg1 = @(t) R1(t) + 20;

% Esquina inferior izquierda
x1 = p1 - sqrt(40^2-20^2);
y1 = yg1(x1);

% Esquina inferior derecha
x2 = p1 + sqrt(40^2-20^2);
y2 = yg1(x2);

% Esquina superior derecha
x3 = x2;
y3 = yg1(x3)+30;

% Esquina superior izquierda
x4 = x1;
y4 = yg1(x4)+30;

% Graficar
vert = [x1, y1; x2, y2; x3, y3; x4, y4];
patch('Faces', [1 2 3 4], 'Vertices', vert, 'FaceColor','red','FaceAlpha',.3)
hold on

% Gradas cerca del mínimo

% Recta base de las gradas (agregar distancia de seguridad)
yg2 = @(t) R2(t) - 20;

% Esquina superior izquierda
x1 = p2 - sqrt(40^2-20^2);
y1 = yg2(x1);

% Esquina superior derecha
x2 = p2 + sqrt(40^2-20^2);
y2 = yg2(x2);

% Esquina inferior derecha
x3 = x2;
y3 = yg2(x3)-30;

% Esquina inferior izquierda
x4 = x1;
y4 = yg2(x4)-30;

% Graficar
vert = [x1, y1; x2, y2; x3, y3; x4, y4];
patch('Faces', [1 2 3 4], 'Vertices', vert, 'FaceColor','red','FaceAlpha',.3)
hold on

%% COCHE

car=plot(t(1),polyval(P,t(1)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); %Definimos el gráfico como una variable

tx = text(300,350,['Posicion en X = ' num2str(t(1))]);
ty = text(300,340,['Posicion en Y = ' num2str(polyval(P,t(1)))]);

% Se otiene un número aleatorio:
opcion = randi(3);

% 1 significa que el coche no se descarrila
if opcion == 1
    for i=1:length(t)
        delete(car); delete(tx); delete(ty); % Borrar coche anterior
        car=plot(t(i),polyval(P,t(i)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); % Graficar coche ahora
        
        % Coordenadas
        tx = text(400,500,['Posicion en X = ', num2str(t(i))]);
        ty = text(400,250,['Posicion en Y = ' num2str(polyval(P,t(i )))]);

        drawnow; % Animar
    end

% 2 significa que el coche se descarrila en la primera zona crítica
elseif opcion == 2
    t = 300:25:865.87;
    % Animar normal hasta el punto de descarrilamiento
    for i=1:length(t)
        delete(car); delete(tx); delete(ty); % Borrar coche anterior
        car=plot(t(i),polyval(P,t(i)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); % Graficar coche ahora
        
        % Coordenadas
        tx = text(400,500,['Posicion en X = ', num2str(t(i))]);
        ty = text(400,250,['Posicion en Y = ' num2str(polyval(P,t(i )))]);

        drawnow; % Animar
    end
    hold on

    % Animar coche siguiendo recta tangente
    t = 865.87:25:1065.87;
    for i=1:length(t)
        delete(car); delete(tx); delete(ty); % Borrar coche anterior
        car=plot(t(i),R1(t(i)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); % Graficar coche ahora
        
        % Coordenadas
        tx = text(400,500,['Posicion en X = ', num2str(t(i))]);
        ty = text(400,250,['Posicion en Y = ' num2str(polyval(P,t(i )))]);

        drawnow; % Animar
    end 
% 3 significa que el coche se descarrila en la segunda zona crítica
else
    t = 300:25:2421.7;
    % Animar normal hasta el punto de descarrilamiento
    for i=1:length(t)
        delete(car); delete(tx); delete(ty); % Borrar coche anterior
        car=plot(t(i),polyval(P,t(i)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); % Graficar coche ahora
        
        % Coordenadas
        tx = text(400,500,['Posicion en X = ', num2str(t(i))]);
        ty = text(400,250,['Posicion en Y = ' num2str(polyval(P,t(i )))]);

        drawnow; % Animar
    end
    hold on

    % Animar coche siguiendo recta tangente
    t = 2421.7:25:2621.7;
    for i=1:length(t)
        delete(car); delete(tx); delete(ty); % Borrar coche anterior
        car=plot(t(i),R2(t(i)),'rv', 'MarkerSize', 5, 'MarkerFaceColor','r'); % Graficar coche ahora
        
        % Coordenadas
        tx = text(400,500,['Posicion en X = ', num2str(t(i))]);
        ty = text(400,250,['Posicion en Y = ' num2str(polyval(P,t(i )))]);
        
        drawnow; % Animar
    end
end
