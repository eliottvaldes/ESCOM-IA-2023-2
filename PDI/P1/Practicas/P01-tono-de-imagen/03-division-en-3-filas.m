
%{
THIS FILE IS A PART OF THE PROJECT "DIGITAL IMAGE PROCESSING"

This file takes an image and separate it into 3 parts using the rows
and show the image with the red, green and blue components using a subplot

Author: Eliot Valdés
%}

clc
warning off all

% read the image peppers.png and store in a variable image
image = imread('peppers.png');

% the original iamge will be separate as the following way:
% separate the image into 3 parts using the rows
% get the total number of rows
% store the first 1/3 of total rows in a variable image1
% store the second 1/3 of total rows in a variable image2
% store the third 1/3 of total rows in a variable image3

% get the total number of rows
total_rows = size(image,1);

% store the first 1/3 of total rows in a variable image1
image1 = image(1:total_rows/3,:,:);

% store the second 1/3 of total rows in a variable image2
image2 = image(total_rows/3+1:2*total_rows/3,:,:);

% store the third 1/3 of total rows in a variable image3
image3 = image(2*total_rows/3+1:total_rows,:,:);

% turn off the color compoenets to show only the red
image1(:,:,2) = 0;
image1(:,:,3) = 0;

% turn off the color compoenets to show only the green
image2(:,:,1) = 0;
image2(:,:,3) = 0;

% turn off the color compoenets to show only the blue
image3(:,:,1) = 0;
image3(:,:,2) = 0;

% show the images with the red, green and blue components using a subplot
subplot(3,1,1), imshow(image1);
subplot(3,1,2), imshow(image2);
subplot(3,1,3), imshow(image3);

