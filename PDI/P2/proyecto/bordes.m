% deteccion basica de bordes
clc, clear, close all, warning off all;

I = imread("coins.png");
figure(1), imshow(I), title("Original");

% deteccion de bordes con metodo SOBEL Y CANNY
% primero de debe de tener la imagen en escala de grises
% I = rgb2gray(I); % para la imagen 'coins.png' ya esta en escala de grises

% Metodo SOBEL: resalta bordes exteriores
I_Sobel = edge(I, "sobel");
% Metodo CANNY: resalta bordes exteriores e interiores (utiliza derivada)
I_Canny = edge(I, "canny");
I_Prewitt = edge(I, "prewitt");
I_Roberts = edge(I, "roberts");
I_Log = edge(I, "log");
I_Zero = edge(I, "zerocross");

% figure(1), imshow(I_Sobel), title("SOBEL");
% figure(2), imshow(I_Canny), title("CANNY");
% figure(3), imshow(I_Prewitt), title("PREWITT");
% figure(4), imshow(I_Roberts), title("ROBERS");
% figure(5), imshow(I_Log), title("LOG");
% figure(6), imshow(I_Zero), title("ZERO");
figure(2),
subplot(2,3,1), imshow(I_Sobel), title("SOBEL");
subplot(2,3,2), imshow(I_Canny), title("CANNY");
subplot(2,3,3), imshow(I_Prewitt), title("PREWITT");
subplot(2,3,4), imshow(I_Roberts), title("ROBERS");
subplot(2,3,5), imshow(I_Log), title("LOG");
subplot(2,3,6), imshow(I_Zero), title("ZERO");
