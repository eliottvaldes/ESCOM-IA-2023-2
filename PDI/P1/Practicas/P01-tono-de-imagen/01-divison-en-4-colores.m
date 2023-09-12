
%{
THIS FILE IS A PART OF THE PROJECT "DIGITAL IMAGE PROCESSING"

This file takes a color image and separates it in 4 images, each one
containing only one of the color components of the original image.
The 4 images are modified to show only one color component.
Finally, the 4 images are shown in a subplot.


Author: Eliot Valdés
%}

clc
warning off all

% read the image peppers.png and store in a variable image
image = imread('peppers.png');

% separate the image in 4 variables
% the separation will be done in the following way:
% get the total number of columns and divide by 2
% get the total number of rows and divide by 

%the first variable will containe the first division of cols and first rows
%the second variable will containe the second division of cols and first of rows
%the third variable will containe the first division of cols and second of rows
%the fourth variable will containe the second division of cols and second of rows

% get the total number of columns
cols = size(image,2);
% get the total number of rows
rows = size(image,1);

% get the first division of cols and first rows
image1 = image(1:rows/2,1:cols/2,:);
% get the second division of cols and first of rows
image2 = image(1:rows/2,cols/2+1:cols,:);
% get the first division of cols and second of rows
image3 = image(rows/2+1:rows,1:cols/2,:);
% get the second division of cols and second of rows
image4 = image(rows/2+1:rows,cols/2+1:cols,:);


% apagamos los demas componentes de color para solo mostrar el rojo
image2(:,:,2) = 0;
image2(:,:,3) = 0;

% apagamos los componentes para solo mostrar el verde
image3(:,:,1) = 0;
image3(:,:,3) = 0;

% apagamos los componentes para solo mostrar el azul
image4(:,:,1) = 0;
image4(:,:,2) = 0;



% show the images in a subplot
subplot(2,2,1), imshow(image1);
subplot(2,2,2), imshow(image2);
subplot(2,2,3), imshow(image3);
subplot(2,2,4), imshow(image4);