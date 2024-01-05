% FILTROS DE ALTA FRECUENCIA PARA RESALTAR BORDES
clc, clear, warning off all, close all;

% leemos imagen
I = imread("pears.png");
%I = imread("images/img_2.jpg");

%% DEFINIMOS FILTROS DE ALTA FRECUENCIA PUES SOLO DEJAN PASAR VALORES DE ALTO CONTRASTE
% NOS SIRVEN PARA RESALTAR BORDES EN CIERTAS IMAGENES

% vamos a usar el filtro definido como: "Parks-McClellan optimal FIR filter
% design"

% transformamos a tipo double para obtener un rango mayor de valores,
% normalizamos y pasamos a escala de grises
I = (double(I)/255); 
i_grises = rgb2gray(I);

figure(), imshow(i_grises), title("Original escala grises");

% definimos nuestro filtro equiparable de paso alto
filter_parks = firpm(16, [0 0.1 0.3 1], [0 0 1 1]);
% transformamos el filtro apra que sea aplicable a 2d
filter_parks = ftrans2(filter_parks);

% filtramos nuestra imagen
i_filtrada = filter2(filter_parks, i_grises);

% mostramos los bordes detectados
figure(), imshow(i_filtrada), title("Imagen filtrada");

% sumamos las imagenes para realzar los bordes
figure(), imshow(i_grises+i_filtrada), title("Imagen con bordes resaltados");

