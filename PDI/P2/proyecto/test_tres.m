clc, clear, close all;

% EJECUTAMOS LA FUNCION
buscar_imagenes_similares();


function buscar_imagenes_similares()
    % Cargar datos del archivo CSV
    datos = readtable('./datasets/data.csv');

    % Crear interfaz gráfica
    f = figure('Name', 'Selector de Imágenes', 'NumberTitle', 'off');

    % Lista desplegable para seleccionar imagen
    uicontrol(f, 'Style', 'popupmenu', 'String', unique(datos.Imagen), ...
              'Position', [20 340 260 50], 'Callback', @seleccionarImagen);

    % Función para manejar la selección de imagen
    function seleccionarImagen(src, ~)
        imagenSeleccionada = src.String{src.Value};
        mostrarImagenesSimilares(imagenSeleccionada, datos);
    end
end

function mostrarImagenesSimilares(imagenSeleccionada, datos)
    % Filtrar datos para la imagen seleccionada
    datosImagen = datos(strcmp(datos.Imagen, imagenSeleccionada), :);

    % Calcular similitud con otras imágenes
    similitudes = arrayfun(@(x) calcularSimilitud(datosImagen, ...
                      datos(strcmp(datos.Imagen, datos.Imagen{x}), :)), ...
                      1:height(datos));

    % Ordenar y seleccionar las 3 más similares
    [~, indices] = sort(similitudes);
    imagenesSimilares = unique(datos.Imagen(indices(1:3)));

    % Mostrar imágenes similares
    figure;
    subplot(2,3,2), imshow("./images/"+imagenSeleccionada), title("Seleccion");
    for i = 1:length(imagenesSimilares)         
        subplot(2, 3, i+3);
        imshow(['./images/' imagenesSimilares{i}]);
        title(['Similar ' num2str(i)]);
    end
end

function similitud = calcularSimilitud(datosImagen, datosComparacion)
    % Aquí se implementa el algoritmo para calcular la similitud
    % entre la imagen seleccionada y otra imagen del dataset.
    % Esto podría basarse en la diferencia de las características
    % como área, perímetro y circularidad.
    % Ejemplo simple: diferencia promedio
    similitud = mean(abs(datosImagen.Area - mean(datosComparacion.Area)) + ...
                     abs(datosImagen.Perimetro - mean(datosComparacion.Perimetro)) + ...
                     abs(datosImagen.Circularidad - mean(datosComparacion.Circularidad)));
end

