% OPERACIONES MORFOLOGICAS
clc, clear, close all, warning off all;

I = imread("coins.png");
%I = rgb2gray(I);
%I = imbinarize(I);

arbitrario = strel("arbitrary", 10);
lineal = strel("line", 10, 10);
disco = strel("disk", 10);
cuadro = strel("square", 10);

apertura_arbitrario = imopen(I,arbitrario);
apertura_lineal = imopen(I,lineal);
apertura_disco = imopen(I,disco);
apertura_cuadro = imopen(I,cuadro);

figure(1), 
subplot(2,2,1), imshow(apertura_arbitrario), title("Arbitrario")
subplot(2,2,2), imshow(apertura_lineal), title("lineal")
subplot(2,2,3), imshow(apertura_disco), title("Disco")
subplot(2,2,4), imshow(apertura_cuadro), title("Cuadrado");

% binarizamos imagen original
bw = im2bw(apertura_arbitrario); 
figure(2), imshow(bw), title("Imagen binarizada");

% invertimos tonalidades
bw = bw==0; 
figure(3), imshow(bw), title("Imagen invertida");

% rellenamos espacios en blanco
%bw = imfill(bw, "holes");
%figure(4), imshow(bw), title("Agujeros rellenados");

bw = medfilt2(bw);
figure(5), imshow(bw), title("Promediamos la imagen");