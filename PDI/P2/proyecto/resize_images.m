clear, clc, close all, warning off all;

% Carga la imagen original
imagenOriginal = imread('./images/img_1.jpg');

% Especifica el nuevo tamaño deseado (por ejemplo, 50% del tamaño original)
nuevoAncho = size(imagenOriginal, 2) * 0.5; % Ancho nuevo
nuevaAltura = size(imagenOriginal, 1) * 0.5; % Altura nueva

% Redimensiona la imagen con diferentes métodos de interpolación
imagenRedimensionada_nearest = imresize(imagenOriginal, [nuevaAltura, nuevoAncho], 'nearest');
imagenRedimensionada_bilinear = imresize(imagenOriginal, [nuevaAltura, nuevoAncho], 'bilinear');
imagenRedimensionada_bicubic = imresize(imagenOriginal, [nuevaAltura, nuevoAncho], 'bicubic');

% Muestra las imágenes redimensionadas
subplot(2, 2, 1), imshow(imagenOriginal), title('Original');
subplot(2, 2, 2), imshow(imagenRedimensionada_nearest), title('Interpolación más cercana');
subplot(2, 2, 3), imshow(imagenRedimensionada_bilinear), title('Interpolación bilineal');
subplot(2, 2, 4), imshow(imagenRedimensionada_bicubic), title('Interpolación bicúbica');
