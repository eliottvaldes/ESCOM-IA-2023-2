clear, clc, close all;

image_similarity_finder();

function image_similarity_finder
    % Cargar datos del CSV
    data = readtable('./datasets/data.csv');
    
    % Crear GUI
    fig = uifigure('Name', 'Image Similarity Finder', 'Position', [100 100 600 400]);
    btn = uibutton(fig, 'push', 'Text', 'Select Image', 'Position', [250, 350, 100, 22], 'ButtonPushedFcn', @(btn,event) selectImage(data));
end

function selectImage(data)
    % Permitir al usuario seleccionar una imagen
    [file, path] = uigetfile('./images/*.jpg');
    if isequal(file, 0)
        return;
    end
    selectedImage = imread(fullfile(path, file));

    % Mostrar imagen seleccionada
    figure;
    subplot(2, 3, 2);
    imshow(selectedImage);
    title('Seleccion');

    % Encontrar y mostrar imágenes similares
    similarImages = findSimilarImages(file, data);
    for i = 1:3
        subplot(2, 3, i+3);
        imshow(imread(fullfile('./images', similarImages{i})));
        title(['Similar ' num2str(i)]);
    end
end

function similarImages = findSimilarImages(selectedFile, data)
    % Extraer características de la imagen seleccionada
    selectedFeatures = data(strcmp(data.Imagen, selectedFile), :);

    % Calcular la similitud con otras imágenes
    similarityScores = zeros(height(data), 1);
    uniqueImages = unique(data.Imagen);
    for i = 1:length(uniqueImages)
        if strcmp(uniqueImages{i}, selectedFile)
            continue;
        end
        imageFeatures = data(strcmp(data.Imagen, uniqueImages{i}), :);
        similarityScores(i) = calculateSimilarity(selectedFeatures, imageFeatures);
    end

    % Encontrar las tres imágenes más similares
    [~, idx] = sort(similarityScores, 'descend');
    similarImages = uniqueImages(idx(1:3));
end

function score = calculateSimilarity(features1, features2)
    % Inicializar el puntaje de similitud
    score = 0;

    % Calcular el número de objetos en cada imagen
    numObjects1 = size(features1, 1);
    numObjects2 = size(features2, 1);

    % Comprobar si alguna de las imágenes no tiene objetos
    if numObjects1 == 0 || numObjects2 == 0
        score = 0;
        return;
    end

    % Encontrar el mínimo número de objetos en ambas imágenes
    minObjects = min(numObjects1, numObjects2);

    % Calcular la diferencia de características para cada objeto
    for i = 1:minObjects
        diffArea = abs(features1.Area(i) - features2.Area(i)) / max(features1.Area(i), features2.Area(i));
        diffPerimeter = abs(features1.Perimetro(i) - features2.Perimetro(i)) / max(features1.Perimetro(i), features2.Perimetro(i));
        diffCircularity = abs(features1.Circularidad(i) - features2.Circularidad(i)) / max(features1.Circularidad(i), features2.Circularidad(i));

        % Sumar las diferencias normalizadas
        score = score + diffArea + diffPerimeter + diffCircularity;
    end

    % Normalizar el puntaje de similitud
    score = 1 - (score / (3 * minObjects));
end