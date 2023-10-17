close all
clc
warning off all


% establecer una matriz de 5x5 con los valores de la matriz de la iamgen
matriz = [0 0 2 2 9; 2 5 5 2 5; 3 3 6 5 5; 3 6 8 5 5; 2 8 8 6 8];
a = double(matriz);

% Solicitar al usuario que ingrese los límites para ajustar
disp('Ingrese los límites que desea ajustar');
minimo = 3;
maximo = 12;

% Obtener los valores mínimos y máximos de cada componente de color
minimo_matriz = min(min(a));
maximo_matriz = max(max(a));
% usa la funcion NEW = (NEWMIN + (NEWMAX - NEWMIN) * (OLD - OLDMIN) / (OLDMAX - OLDMIN))
New = (minimo + (maximo - minimo) * (a - minimo_matriz) / (maximo_matriz - minimo_matriz));

z = round(New);
pixeles = uint8(z); % obtiene los valores de los píxeles en la ubicación (i,j)



% mostrar el histograma de la matriz 
subplot(1,2,1);
bar((matriz));
title('Histograma Original')


% Mostrar el histograma expandido
subplot(1,2,2);
bar((pixeles));
title('Histograma Resultante')


disp('Fin del ejercicio 3')


