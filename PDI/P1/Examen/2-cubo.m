close all
clc



% define un arreglo para elementos de la clase c1
% cada elemento es una esquina del cubo unitario
% definimos un arreglo para elementos de la clase c1
c1 = [0 0 0; 1 0 0; 1 0 1; 1 1 0];
% define un arreglo para elementos de la clase c2
c2 = [0 1 1; 0 1 0; 0 0 1; 1 1 1];

% grafica los puntos de la c1 y c2 (usando las coordenadas) dentro de un cubo 3d usando scatter3 
% ayudamen graficando una linea que vaya del punto (0,0,0) al punto (1,1,1)
% usa la funcion plot3
figure
% graficando los vetices
scatter3(c1(:,1),c1(:,2),c1(:,3),'filled','r')
hold on
scatter3(c2(:,1),c2(:,2),c2(:,3),'filled','b')
hold off

% graficando las lineas
hold on
plot3([0 1],[0 1],[0 1],'k')
hold off

title('Puntos de las clases c1 y c2')
xlabel('x')
ylabel('y')


%% ahora vamos a aplicar el clasificador de distancia mínima

% obtenemos el promedio de c1
mean_c1 = mean(c1);

% obtenemos el promedio de la clase 2
mean_c2 = mean(c2);

% solicitamos un vector por teclado que sea de 3 elementos
input_vector = input('Introduce un vector de 3 elementos (ejemplo: [0.5 0.3 0.7]): ');

% verificamos que todos los valores del vector sean mayores o igual a 0 y menores o igual a 1
if all(input_vector >= 0) && all(input_vector <= 1)
    % obtenemos la distancia del punto a cada una de las clases
    dist_to_c1 = norm(input_vector - mean_c1);
    dist_to_c2 = norm(input_vector - mean_c2);

    % obtenemos la clase a la que pertenece el punto
    if dist_to_c1 < dist_to_c2
        disp('El punto pertenece a la clase c1.');
    else
        disp('El punto pertenece a la clase c2.');
    end
else
    disp('El vector ingresado contiene valores fuera del rango [0, 1].');
end


disp('Fin ejercicio 2')
