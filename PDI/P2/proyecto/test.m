% proyecto de PDI
clc; clear; warning off all; close all;
imageName = 'img_27';
% obtener la imagen
I = imread("images/" + imageName + ".jpg");

% redimencionamos la imagen
I = imresize(I, 0.2, 'bicubic'); % Simplificado

% Convertir a doble y resaltar bordes
I = im2double(I);
filter_parks = firpm(16, [0 0.1 0.4 1], [0 0 1 1]);
filter_parks = ftrans2(filter_parks);
I = I + filter2(filter_parks, rgb2gray(I));
I = min(max(I * 1.1, 0), 1); % Saturación y rango [0, 1]

% Preprocesamiento y segmentación
I = imbinarize(wiener2(im2gray(I), [5 5]));
I = bwareaopen(I, 900);
SE = strel('disk', 6);
I = imclose(I, SE);
I = bwareaopen(I, 500);
I = imerode(I, SE);
I = ~I;

% Etiquetar y filtrar objetos
[L, num] = bwlabel(I);
propiedades = regionprops(L, 'Area');
I_filtrada = false(size(I));
for k = 1:num
    if propiedades(k).Area >= 8000
        I_filtrada = I_filtrada | (L == k);
    end
end
I = I_filtrada;

% Abrir archivo CSV
fid = fopen('./datasets/data.csv', 'w');
fprintf(fid, '%s,%s,%s,%s\n', 'Imagen', 'Area', 'Perimetro', 'Circularidad');

% Procesamiento y visualización
figure(); imshow(I); hold on;

for k = 1:num
    objeto = (L == k) & I_filtrada;
    if any(objeto(:))
        area = bwarea(objeto);
        perimetro = sum(bwperim(objeto, 8), 'all');
        circularidad = (4 * pi * area) / (perimetro^2);
        fprintf(fid, '%s,%f,%f,%f\n', imageName, area, perimetro, circularidad);
        
        % Dibujo y etiquetas
        boundary = bwboundaries(objeto);
        plot(boundary{1}(:,2), boundary{1}(:,1), 'g', 'LineWidth', 2);
        stats = regionprops(objeto, 'Centroid');
        texto = sprintf('Área: %.2f, Perímetro: %.2f, Circularidad: %.2f', area, perimetro, circularidad);
        text(stats.Centroid(1), stats.Centroid(2), texto, 'EdgeColor', 'b', 'BackgroundColor', 'white');
    end
end

% Cerrar archivo CSV
fclose(fid);
