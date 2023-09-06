clc % limpia todo
close all
clear all
warning off all
clc

disp('Mostrando mensaje en pantalla');

% leemos imagen
image= imread('peppers,png');

% obtenenos los rojos de la imagen
image_red = image
% definimos escala de grises de la componente roja
image_red(:,:,1);
% definimos un subplot
subplot(2,3,1);
% mostramos la imagen 
imshow(image_red(:,:,1));
title('Componente gris-roja');

% obtenenos los verdes de la imagen
image_green = image
% apagamos los demas componentes de color
image_green(:,:,1) = 0;
image_green(:,:,2);
image_green(:,:,3) = 0;
% definimos un subplot
subplot(2,3,2);
% mostramos la imagen 
imshow(image_green(:,:,2));
title('Componente gris-verde');

% obtenenos los azules de la imagen
image_blue = image
% apagamos los demas componentes de color
image_blue(:,:,1) = 0;
image_blue(:,:,2) = 0;
image_blue(:,:,3);
% definimos un subplot
subplot(2,3,3);
% mostramos la imagen 
imshow(image_blue(:,:,3));
title('Componente gris-azul');


% obtenemos la imagen en escala de grises
% esta escala de grises es el promedio de los componentes de las escalas de grsises de cada RGB
image_gray = rgb2gray(image);
% definimos un subplot
subplot(2,3,1);
% mostramos la imagen
imshow(image_gray);
title('Escala de grises');
