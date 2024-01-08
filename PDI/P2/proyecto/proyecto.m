% proyecto de PDI
clc, clear, warning off all, close all;
imageName = 'img_3';
% obtener la imagen
I = imread("images/" + imageName + ".jpg");

% redimencionamos la imagen
newWidth = size(I, 2) * 0.2; % Ancho nuevo
newHeigth  = size(I, 1) * 0.2; % Altura nueva
% Redimensiona la imagen con diferentes métodos de interpolación
I = imresize(I, [newHeigth, newWidth], 'bicubic');

% Convertir la imagen a tipo de datos de punto flotante de doble precisión
I = im2double(I);
% definimos la imagen original
original = I;

% resaltamos contornos
filter_parks = firpm(35, [0 0.05 0.5 1], [0 0 1 1]);
filter_parks = ftrans2(filter_parks);
% aplicamos filtro
I_filtered = filter2(filter_parks, rgb2gray(I));
%figure(2), imshow(I_filtered), title("Tratamiendo de bordes");

% sumamos para resaltar los bordes
I = I + I_filtered;
%figure(3), imshow(I), title("Bordes Resaltados");

% multiplicamos por factor de saturacion
imagen_saturada = I * 0.7;
% Asegurarse de que los valores estén en el rango [0, 1]
I = min(max(imagen_saturada, 0), 1);
%figure(4), imshow(I), title("Saturada");

% obtenemos escala de grises
I = im2gray(I);
%figure(5), imshow(I), title("Escala de grises");

% suavizamos el ruido dentro de la imagen
I= wiener2(I, [5 5]);

I = imbinarize(I);
%figure(6), imshow(I), title("Binarizada");


% seguimos eliminando ruido
% eliminamos las regiones que tengan menos de 500 px
I = bwareaopen(I, 500);

%
% rellenamos espacio en objetos
SE = strel('arbitrary', 10);
% SE = strel("diamond", 3);
I = imclose(I, SE);
%figure(7), imshow(I), title("Rellenado de espacios con cierre de imagen");
%
I = bwareaopen(I, 500);

% rellenamos espacio en objetos
SE = strel('disk', 6, 8);
I = imerode(I, SE);
%figure(9), imshow(I), title("Erosion aplicada");

% invertimos colores
I = I == 0;

% Etiquetar los objetos conectados
[L, num] = bwlabel(I);
% Calcular el área de cada objeto
propiedades = regionprops(L, 'Area');
% Inicializar una imagen para los objetos con área >= 2000
I_filtrada = false(size(I));
% Bucle para revisar cada objeto
for k = 1:num
    if propiedades(k).Area >= 2000 && propiedades(k).Area < 15000
        % Conservar los objetos con área >= 2000
        I_filtrada = I_filtrada | (L == k);
    end
end
I = I_filtrada;
%figure(10), imshow(I), title("Eliminacion de areas");


% usamos contornos exteriores para caracterizar cada objeto
[B, L] = bwboundaries(I, 8, "holes");
objetos = label2rgb(L, @jet, [.5 .5 .5]);

figure(11),imshowpair(original, objetos, "montage"), title("Imagen original y bordes");
% 
% figure(),imshow(B);

% Preparar para visualización
figure();
imshow(I); % Mostrar imagen original
hold on; % Mantener la imagen para dibujar sobre ella

for k = 1:num
    % Características de objeto
    objeto = L == k;
    area = bwarea(objeto);
    perimetro = bwperim(objeto);
    perimetro = sum(perimetro(:));
    circularidad = (4 * pi * area) / (perimetro^2);

    % Filtrar por área y guardar datos
    if area >= 2000
          % Resaltar objeto
        boundary = bwboundaries(objeto);
        plot(boundary{1}(:,2), boundary{1}(:,1), 'g', 'LineWidth', 2);

        % Etiquetar objeto
        stats = regionprops(objeto, 'Centroid');
        texto = sprintf('Área: %.2f, Perímetro: %.2f, Circularidad: %.2f', area, perimetro, circularidad);
        text(stats.Centroid(1), stats.Centroid(2), texto, 'EdgeColor', 'b', 'BackgroundColor', 'white');

    end
end