clear, clc, close all;

image_similarity_finder();


function image_similarity_finder
    % Cargar datos del CSV solo una vez
    persistent data;
    if isempty(data)
        data = readtable('./datasets/data.csv');
    end
    
    % Crear GUI solo si aún no existe
    if isempty(findall(0, 'Type', 'Figure', 'Name', 'Buscador de similitudes'))
        fig = uifigure('Name', 'Buscador de similitudes en imagenes', 'Position', [100 100 600 400]);
        uibutton(fig, 'push', 'Text', 'Selecciona la imagen', 'Position', [250, 350, 100, 22], 'ButtonPushedFcn', @(btn, event) selectImage(data));
    end
end

function selectImage(data)
    [file, path] = uigetfile('./images/*.jpg');
    if isequal(file, 0)
        return;
    end
    selectedImage = imread(fullfile(path, file));

    % Mostrar imagen seleccionada y preparar para imágenes similares
    f = figure('Name', 'Imagen seleccionada y similares', 'NumberTitle', 'off');
    ax1 = subplot(2, 3, 2);
    imshow(selectedImage, 'Parent', ax1);
    title(ax1, 'Seleccion');

    % Encontrar y mostrar imágenes similares de forma eficiente
    similarImages = findSimilarImages(file, data);
    for i = 1:length(similarImages)
        ax = subplot(2, 3, i+3);
        %imshow(imread(fullfile('./imagesObjects', similarImages{i})), 'Parent', ax);
        imshow(imread(fullfile('./images', similarImages{i})), 'Parent', ax);
        title(ax, ['Similar ' num2str(i)]);
    end
end

function similarImages = findSimilarImages(selectedFile, data)
    selectedFeatures = data(strcmp(data.Imagen, selectedFile), :);

    % Optimización: Calcular similitud usando operaciones matriciales
    uniqueImages = unique(data.Imagen);
    uniqueImages(strcmp(uniqueImages, selectedFile)) = [];
    similarityScores = arrayfun(@(x) calculateSimilarity(selectedFeatures, data(strcmp(data.Imagen, uniqueImages{x}), :)), 1:length(uniqueImages));

    % Obtener las tres imágenes más similares
    [~, idx] = sort(similarityScores, 'descend');
    similarImages = uniqueImages(idx(1:3));
end

function score = calculateSimilarity(features1, features2)
    % Comparación del número de objetos en cada imagen
    numObjects1 = size(features1, 1);
    numObjects2 = size(features2, 1);
    objectCountDifference = abs(numObjects1 - numObjects2);

    % Penalización por diferencias en el número de objetos
    objectCountPenalty = objectCountDifference * 0.1;

    % Cálculos originales
    numObjects = min(numObjects1, numObjects2);
    if numObjects == 0
        score = 0 - objectCountPenalty;
        return;
    end

    diffArea = sum(abs(features1.Area(1:numObjects) - features2.Area(1:numObjects)) ./ max(features1.Area(1:numObjects), features2.Area(1:numObjects)));
    diffPerimeter = sum(abs(features1.Perimetro(1:numObjects) - features2.Perimetro(1:numObjects)) ./ max(features1.Perimetro(1:numObjects), features2.Perimetro(1:numObjects)));
    diffCircularity = sum(abs(features1.Circularidad(1:numObjects) - features2.Circularidad(1:numObjects)) ./ max(features1.Circularidad(1:numObjects), features2.Circularidad(1:numObjects)));

    % Calcula la puntuación con la penalización
    score = 1 - ((diffArea + diffPerimeter + diffCircularity) / (3 * numObjects)) - objectCountPenalty;
end
% function score = calculateSimilarity(features1, features2)
%     % Optimización: Uso de operaciones vectorizadas para cálculo de similitud
%     numObjects = min(size(features1, 1), size(features2, 1));
%     if numObjects == 0
%         score = 0;
%         return;
%     end
% 
%     diffArea = sum(abs(features1.Area(1:numObjects) - features2.Area(1:numObjects)) ./ max(features1.Area(1:numObjects), features2.Area(1:numObjects)));
%     diffPerimeter = sum(abs(features1.Perimetro(1:numObjects) - features2.Perimetro(1:numObjects)) ./ max(features1.Perimetro(1:numObjects), features2.Perimetro(1:numObjects)));
%     diffCircularity = sum(abs(features1.Circularidad(1:numObjects) - features2.Circularidad(1:numObjects)) ./ max(features1.Circularidad(1:numObjects), features2.Circularidad(1:numObjects)));
% 
%     score = 1 - ((diffArea + diffPerimeter + diffCircularity) / (3 * numObjects));
% end

