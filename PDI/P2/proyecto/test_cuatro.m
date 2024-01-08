clc, clear, close all;

% Ejecutar el programa principal
main();

function main()
    % Cargar y procesar el archivo CSV
    data = readtable('./datasets/data.csv');
    
    % Crear la interfaz gráfica
    hFig = figure('Name', 'Selector de Imágenes', 'NumberTitle', 'off');
    uicontrol('Style', 'pushbutton', 'String', 'Seleccionar Imagen', ...
        'Position', [20, 20, 100, 30], 'Callback', {@selectImageCallback, data});
end

function selectImageCallback(~, ~, data)
    % Permitir al usuario seleccionar una imagen
    [filename, pathname] = uigetfile('./images/*.jpg', 'Selecciona una imagen');
    if isequal(filename, 0)
        return;
    end
    selectedImage = fullfile(pathname, filename);
    
    % Encontrar las tres imágenes más similares
    similarImages = findSimilarImages(selectedImage, data);
    
    % Mostrar las imágenes similares
    for i = 1:length(similarImages)
        subplot(1, 3, i);
        imshow(fullfile('./images', similarImages{i}));
        title(similarImages{i});
    end
end

function similarImages = findSimilarImages(selectedImage, data)
    % Extraer los datos de la imagen seleccionada
    [~, name, ~] = fileparts(selectedImage);
    selectedData = data(strcmp(data.Imagen, name + ".jpg"), :);

    % Inicializar la matriz de similitud
    uniqueImages = unique(data.Imagen);
    similarityScores = zeros(length(uniqueImages), 1);

    % Calcular la similitud con todas las otras imágenes
    for i = 1:length(uniqueImages)
        if uniqueImages{i} == name + ".jpg"
            continue; % Ignorar la imagen seleccionada
        end
        comparisonData = data(strcmp(data.Imagen, uniqueImages{i}), :);
        similarityScores(i) = calculateSimilarity(selectedData, comparisonData);
    end

    % Seleccionar las tres imágenes más similares
    [~, idx] = sort(similarityScores, 'descend');
    similarImages = uniqueImages(idx(1:3));
end

function score = calculateSimilarity(data1, data2)
    % Calcular la similitud entre dos conjuntos de datos (objetos de dos imágenes)
    score = 0;
    for i = 1:height(data1)
        for j = 1:height(data2)
            dist = sqrt((data1.Area(i) - data2.Area(j))^2 + ...
                        (data1.Perimetro(i) - data2.Perimetro(j))^2 + ...
                        (data1.Circularidad(i) - data2.Circularidad(j))^2);
            if dist < 500
                score = score + 1;
            end
        end
    end
end
