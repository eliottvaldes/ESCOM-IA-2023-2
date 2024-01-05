% FILTROS DE BAJA FRECUENCIA PARA ELIMIAR RUIDO

clc, clear, warning off all, close all;

% leemos imagen
I = imread("peppers.png");
% agregamos ruido 'sal y pimienta' a la imagen
I = imnoise(I, "salt & pepper");
% mostramos la imagen con ruido
figure(1), subplot(3,3,1), imshow(I), title("Original con ruido");

%% FILTROS PARA ELIMINAR RUIDO DE FRECUENCIA BAJA
%# RUIDO DE FRECUENCIA BAJA INCLUYE SAL Y PIMIENTA, POISSON, GAUSSIAN, etc

% definimos los filtros existentes en matlab
avarage = fspecial('average');
disk = fspecial("disk") ;
gausian = fspecial("gaussian");
laplaciano = fspecial("laplacian");
log = fspecial("log");
motion = fspecial("motion");
prewit = fspecial("prewitt");
sobel = fspecial("sobel");

% aplicamos filtros a nuestra imagen
filtered_avarage = imfilter(I, avarage);
filtered_disk = imfilter(I, disk);
filtered_gausian = imfilter(I, gausian);
filtered_laplaciano = imfilter(I, laplaciano);
filtered_log = imfilter(I, log);
filtered_motion = imfilter(I, motion);
filtered_prewit = imfilter(I, prewit);
filtered_sobel = imfilter(I, sobel);

% mostramos los filtros
subplot(3,3,2), imshow(filtered_avarage), title("filtered_avarage");
subplot(3,3,3), imshow(filtered_disk), title("filtered_disk");
subplot(3,3,4), imshow(filtered_gausian), title("filtered_gausian");
subplot(3,3,5), imshow(filtered_laplaciano), title("filtered_laplaciano");
subplot(3,3,6), imshow(filtered_log), title("filtered_log");
subplot(3,3,7), imshow(filtered_motion), title("filtered_motion");
subplot(3,3,8), imshow(filtered_prewit), title("filtered_prewit");
subplot(3,3,9), imshow(filtered_sobel), title("filtered_sobel");


% utilizamos un filtro de mediana para aplciar directamente 
% unicamente funciona en 2 dimenciones
filtered_median = medfilt2(rgb2gray(I));
figure(2), imshowpair(I, filtered_median, "montage");
