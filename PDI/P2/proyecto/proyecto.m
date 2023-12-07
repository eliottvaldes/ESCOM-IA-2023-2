% proyecto de PDI
clc
warning off all;
% obtener la imagen
rgb = imread("imagenes/letras.png");
I = im2gray(rgb);

% quitar ruido a la imagen
p_gray  = wiener2(I);

% creamos un umbral para binarizacion
umbral = 0.2;
% binarizamos la imagen
imagen_binaria = imbinarize(p_gray, umbral);

% eliminamos regiones menores a 300 pixeles
imagen_binaria = bwareaopen(imagen_binaria, 500);

% definimos el tipo de erosion a aplciar
SE = strel("disk", 10);
imagen_binaria = imclose(imagen_binaria, SE);

% Mostrar la imagen binaria
imshow(imagen_binaria);
title('Imagen Binaria');


% Encontrar y mostrar contornos
contornos = bwboundaries(imagen_binaria, 8, "noholes");
hold on;
for k = 1:length(contornos)
    borde = contornos{k};

    % Calcular el área del contorno
    area = polyarea(borde(:,2), borde(:,1));

    if(area > 300)

        % Calcular el perímetro
        perimetro = sum(sqrt(sum(diff(borde).^2, 2)));

        % Calcular la circularidad
        circularidad = (4 * pi * area) / perimetro^2;

        % Dibujar los bordes de la imagen
        plot(borde(:, 2), borde(:, 1), 'r', 'LineWidth', 2);

        % Mostrar los datos en la imagen
        texto = sprintf('Circularidad: %.2f\nÁrea: %.2f\nPerímetro: %.2f', ...
            circularidad, area, perimetro);
        text(centroide(2), centroide(1), texto, 'Color', 'green', 'FontSize', 18);

    end

end
hold off;