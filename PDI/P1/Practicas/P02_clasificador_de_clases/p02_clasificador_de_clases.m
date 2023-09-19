clc
close all
warning off all

% Leer la imagen 'peppers.png'
a = imread('peppers.png');

% Solicitar el número de clases a identificar en la imagen
n_clases = input('Ingrese el número de clases a identificar en la imagen: ');

% Solicitar el número de iteraciones para cada clase
iter = input('Ingrese el número de iteraciones para cada clase: ');

% Pedir el nombre de cada clase
name = cell(1, n_clases);
for i = 1:n_clases
    name{i} = input(['Ingrese el nombre de la clase ', num2str(i), ': '], 's');
end

% Inicializar una celda para almacenar las iteraciones de cada clase
class_iterations = cell(1, n_clases);

% Mostrar la imagen y permitir al usuario seleccionar puntos para cada clase
for i = 1:n_clases
    figure('Name', ['Seleccionar puntos para la clase ', name{i}], 'NumberTitle', 'off');
    imshow(a);
    title(['Clase: ', name{i}]);
    hold on;
    for j = 1:iter
        disp(['Seleccione el punto ', num2str(j), ' para la clase ', name{i}]);
        [x, y] = ginput(1);
        class_iterations{i}{j} = [x, y];
        text(x, y, num2str(j), 'Color', 'r', 'FontSize', 12);
    end
    hold off;
    close;
end

% Calcular el promedio de cada clase
class_means = cell(1, n_clases);
for i = 1:n_clases
    class_means{i} = mean(cell2mat(class_iterations{i}));
end

while true
    % Solicitar al usuario que seleccione un punto 'pointxy' dentro de la imagen
    figure('Name', 'Seleccionar un punto', 'NumberTitle', 'off');
    imshow(a);
    title('Seleccione un punto');
    [x, y] = ginput(1);
    pointxy = [x, y];
    close;

    % Calcular la distancia del punto 'pointxy' a cada uno de los promedios de las clases
    distances = zeros(1, n_clases);
    for i = 1:n_clases
        distances(i) = norm(pointxy - class_means{i});
    end

    % Obtener la clase a la que pertenece el punto 'pointxy' utilizando una estructura 'if'
    [~, min_index] = min(distances);
    disp(['El punto pertenece a la clase: ', name{min_index}]);

    % Preguntar al usuario si desea seleccionar otro punto en la imagen
    choice = input('¿Desea seleccionar otro punto? (Sí: 1, No: 0): ');
    if choice == 0
        break;
    end
end
