clc
clear all
close all
warning off all

% Define los puntos y colores de acuerdo a tu especificación
c1 = [0 0 0; 0 0 1; 0 1 0; 0 1 1];
c2 = [1 0 0; 1 0 1; 1 1 0; 1 1 1];
colors = ['k', 'b', 'g', 'c', 'r', 'm', 'y', 'w'];
colorNames = {'Negro', 'Azul', 'Verde', 'Cyan', 'Rojo', 'Magenta', 'Amarillo', 'Blanco'};

figure;

% Genera el cubo tridimensional y agrega las leyendas
for i = 1:size(c1, 1)
    scatter3(c1(i, 1), c1(i, 2), c1(i, 3), 100, colors(i), 'filled');
    text(c1(i, 1), c1(i, 2), c1(i, 3), colorNames{i}, 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    hold on;
end

for i = 1:size(c2, 1)
    scatter3(c2(i, 1), c2(i, 2), c2(i, 3), 100, colors(i+4), 'filled');
    text(c2(i, 1), c2(i, 2), c2(i, 3), colorNames{i+4}, 'FontSize', 12, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    hold on;
end

% Agrega la línea gris entre los puntos C1[0;0;0] y C2[1;1;1]
line([c1(1,1), c2(4,1)], [c1(1,2), c2(4,2)], [c1(1,3), c2(4,3)], 'Color', [0.5 0.5 0.5], 'LineWidth', 2);

xlabel('Eje X');
ylabel('Eje Y');
zlabel('Eje Z');
title('Cubo Tridimensional con Colores, Leyendas y Línea de escala de grises');
grid on;
axis equal;
disp('Fin del proceso...');
