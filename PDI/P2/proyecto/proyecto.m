% proyecto de PDI
clc, clear, warning off all, close all;

% obtener la imagen
I = imread("images/img_6.jpg");
figure(1), imshow(I), title("Original");


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
filter_parks = firpm(16, [0 0.1 0.4 1], [0 0 1 1]);
filter_parks = ftrans2(filter_parks);
% aplicamos filtro
I_filtered = filter2(filter_parks, rgb2gray(I));
figure(2), imshow(I_filtered), title("Tratamiendo de bordes");

% sumamos para resaltar los bordes
I = I + I_filtered;
figure(3), imshow(I), title("Bordes Resaltados");

% multiplicamos por factor de saturacion
imagen_saturada = I * 1.1;
% Asegurarse de que los valores estén en el rango [0, 1]
I = min(max(imagen_saturada, 0), 1);
figure(4), imshow(I), title("Saturada");

% obtenemos escala de grises
I = im2gray(I);
figure(5), imshow(I), title("Escala de grises");

% suavizamos el ruido dentro de la imagen
I= wiener2(I, [5 5]);

I = imbinarize(I);
figure(6), imshow(I), title("Binarizada");


% seguimos eliminando ruido
% eliminamos las regiones que tengan menos de 500 px
I = bwareaopen(I, 900);

%
% rellenamos espacio en objetos
SE = strel('arbitrary', 10);
% SE = strel("diamond", 3);
I = imclose(I, SE);
figure(7), imshow(I), title("Rellenado de espacios con cierre de imagen");
%
I = bwareaopen(I, 9);

% rellenamos espacio en objetos
SE = strel('disk', 6, 8);
I = imerode(I, SE);
figure(8), imshow(I), title("Con erosion");

I = bwareaopen(I, 900);
figure(9), imshow(I), title("Eliminamos mas ruido");

%{
SE = strel("arbitrary", 10);
I = imopen(I, SE);
figure(10), imshow(I), title("Con Apertura");

I = medfilt2(I);
figure(11), imshow(I), title("Promediamos la imagen");
%}

% usamos contornos exteriores para caracterizar cada objeto
[B, L] = bwboundaries(I, 4, "holes");

% test
figure;
imshowpair(original, L, "montage");
title("Imagen original y bordes");
% end test

figure(12), imshow(label2rgb(L, @jet, [.5 .5 .5])), title("Bordes indetificados");

%{
hold on
for k = 1: length(B)    boundary = B(k); % ciclo para dibujar los contornos de las regiones
    plot(boundary(:,2),'w','LineWidth',2)
end

% obtenemos la caracterizacion de la imagen
stats = regionprops(L, 'Area', 'Centroid');
threshold = 0.94;
for k =1:length(B)
    boundary = B(k);
    delta_sq = diff(boundary).^2;
    % obtenemos el perimetro
    perimeter = sum(sqrt(sum(delta_sq, 2)));
    % obtenemos el area
    area = stats(k).Area;
    % obtenemos la metrica usando el area y perimetro
    metric = 4*pi*area/perimeter^2;
    % asignamos metrica a cada region
    metric_string = sprintf('%2.2f', metric);
    if metric > threshold
        % obtenemos el centroide
        centroid = stats(k).Centroid;
        % lo dibujamos en pantalla
        plot(centroid(1), centroid(2), 'ko');
    end
    text(boundary(1,2)-35, boundary(1,1)+13, metric_string, 'Color', 'k', 'FontSize', 20, 'FontWeight', 'bold')
end
%}
