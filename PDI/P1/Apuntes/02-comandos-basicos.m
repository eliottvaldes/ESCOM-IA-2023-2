% COMANDOS BASICOS DE UN SCRIPT DE MATLAP MATLAB

clc % limpia la pantalla
close all % cierra todas las ventanas
clear all % limpia todas las variables
warnings off all % desactiva los mensajes de advertencia
disp('hola mundo') % muestra un mensaje en pantalla


% la extension de los archivos de matlab es .m

% variables
WHOS % muestra las variables que hay en memoria

%%%%%%%%%%%%%%%%
% LECTURA DE PRIMRA IMAGEN

% lectura de la imagen
a = imread('ejemplo.png') % lee la imagen y la guarda en la variable a
figure(1) % crea una ventana
imshow(a) % muestra la imagen en la ventana
title('imagen original') % pone un titulo a la ventana

% IDENTIFICACION DE NIVELES DE GRIS
figure(2) % crea una ventana nueva
grises = rgb2gray(a); 
% convierte la imagen a escala de grises
% internamente hace la operacion: grises = 0.299*a(:,:,1) + 0.587*a(:,:,2) + 0.114*a(:,:,3);

imshow(grises) % muestra la imagen en la ventana
title('imagen en escala de grises') % pone un titulo a la ventana


% BLANCOS Y NEGROS
figure(3) % crea una nueva ventana
b_negro = im2bw(grises) %  transforma la imagen a blanco y negro
imshow(b_negro)

% OBTENECION DE TAMAÑO DE LA IMAGEN
size(a) %  muestra una matriz de 3x3
[m , n] = size(a) % asigna el primer valor de la matriz a m y la multiplicacion del segundo y tercer valor a n


% MOSTRAR LAS 3 IMAGENES EN UNA SOLA PESTAÑA
subplot(1,3,1) %  
imshow(a)
title('original image')

subplot(1,3,2) %  
imshow(grises)
title('Escala de grises')

subplot(1,3,3) %  
imshow(b_negro)
title('Blancos y negros => imagen binaria')

%% OBTENER DE FORMA SEPARADA LOS VALORES 
% OBTENCION DE VALOR ROJO
roja = a; % inicializar los valores de rojo con los valores de a
subplot(2,3,4)
roja(:,:,1); % apagar los valores internos
roja(:,:,2) = 0; 
roja(:,:,3) = 0;
imshow(roja) % mostramos los valores rojos
title('ROJOS')

% OBTENCION DE VALOR VERDE
verde = a; % inicializar los valores de rojo con los valores de a
subplot(2,3,5)
verde(:,:,1) = 0; % apagar los valores internos
verde(:,:,2); 
verde(:,:,3) = 0;
imshow(verde) % mostramos los valores verdes
title('VERDES')

% OBTENCION DE VALOR AZUL
azul = a; % inicializar los valores de rojo con los valores de a
subplot(2,3,6)
azul(:,:,1)= 0; % apagar los valores internos
azul(:,:,2) = 0; 
azul(:,:,3);
imshow(azul) % mostramos los valores azuls
title('AZUL')


figure(2)
arreglo = [color,rojo; verde,azul]
imshow(arrelog)



disp('end of program')
