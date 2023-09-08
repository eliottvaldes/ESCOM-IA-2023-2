clc
warning off all

% read the image peppers.png and store in a variable image
image = imread('peppers.png');

% the image will be separate in 3 equal parts using the columns
% get the total number of columns
% the first part will be stored in the variable image1
% the second part will be stored in the variable image2
% the third part will be stored in the variable image3

% get the total number of columns
[rows, columns, numberOfColorChannels] = size(image);

% get the number of columns for each part
numberOfColumns = columns / 3;

% get the first part
image1 = image(:, 1:numberOfColumns, :);

% get the second part
image2 = image(:, numberOfColumns + 1:2 * numberOfColumns, :);

% get the third part
image3 = image(:, 2 * numberOfColumns + 1:3 * numberOfColumns, :);


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
subplot(1,3,1), imshow(image1);
subplot(1,3,2), imshow(image2);
subplot(1,3,3), imshow(image3);

% define a title for the figure
title('Red, Green and Blue components of the image');




