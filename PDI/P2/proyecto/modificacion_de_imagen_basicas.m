%% MODIFICACION DE IMAGEN CON OPERACIONES MATEMATICAS
% Modificacion de imagen para aumentar brillo, saturacion, etc

clc, clear, warning off all, close all;

% ejemplo de saturacion de imagen
imagen_original = imread('peppers.png');
%imagen = imread("images/img_2.jpg");

% Convertir la imagen a tipo de datos de punto flotante de doble precisión
imagen_double = im2double(imagen_original);

% Definir el factor de aumento de saturación (por ejemplo, 1.5 para aumentar en un 50%)
factor_saturacion = 1.5;

% Aumentar la saturación multiplicando los canales de color por el factor
imagen_saturada = imagen_double * factor_saturacion;

% Asegurarse de que los valores estén en el rango [0, 1]
imagen_saturada = min(max(imagen_saturada, 0), 1);

% Mostrar la imagen saturada
figure(1), imshowpair(imagen_original, imagen_saturada, "montage");