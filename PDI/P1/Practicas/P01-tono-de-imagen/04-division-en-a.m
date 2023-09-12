
%{
THIS FILE IS A PART OF THE PROJECT "DIGITAL IMAGE PROCESSING"

This file takes a color image and separates it in 30 areas
Then we change the color of each area in order to show a letter "A" 
Finally, we show the result in a subplot matrix  

Author: Eliot Valdés
%}
 

clc
warning off all

% read the image peppers.png and store in a variable image
image = imread('peppers.png');

% the original iamge will be separate as the following way:
% get the total number of cols and rows of the image
% the image will be separated in 30 areas
% separate the cols in 6 parts and rows in 5 parts

% get the total number of cols and rows of the image
[rows, cols, numberOfColorChannels] = size(image);

% separate the cols in 6 parts and rows in 5 parts
% the number of cols and rows of each part
colsOfEachPart = floor(cols/6);
rowsOfEachPart = floor(rows/5);

% separate the image in 30 areas
% the first area
area1 = image(1:rowsOfEachPart, 1:colsOfEachPart, :);
% the second area
area2 = image(1:rowsOfEachPart, colsOfEachPart+1:colsOfEachPart*2, :);
% the third area
area3 = image(1:rowsOfEachPart, colsOfEachPart*2+1:colsOfEachPart*3, :);
% the fourth area
area4 = image(1:rowsOfEachPart, colsOfEachPart*3+1:colsOfEachPart*4, :);
% the fifth area
area5 = image(1:rowsOfEachPart, colsOfEachPart*4+1:colsOfEachPart*5, :);

% the sixth area
area6 = image(1:rowsOfEachPart, colsOfEachPart*5+1:cols, :);
% the seventh area
area7 = image(rowsOfEachPart+1:rowsOfEachPart*2, 1:colsOfEachPart, :);
% the eighth area
area8 = image(rowsOfEachPart+1:rowsOfEachPart*2, colsOfEachPart+1:colsOfEachPart*2, :);
% the ninth area
area9 = image(rowsOfEachPart+1:rowsOfEachPart*2, colsOfEachPart*2+1:colsOfEachPart*3, :);
% the tenth area
area10 = image(rowsOfEachPart+1:rowsOfEachPart*2, colsOfEachPart*3+1:colsOfEachPart*4, :);

% the eleventh area
area11 = image(rowsOfEachPart+1:rowsOfEachPart*2, colsOfEachPart*4+1:colsOfEachPart*5, :);
% the twelfth area
area12 = image(rowsOfEachPart+1:rowsOfEachPart*2, colsOfEachPart*5+1:cols, :);
% the thirteenth area
area13 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, 1:colsOfEachPart, :);
% the fourteenth area
area14 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, colsOfEachPart+1:colsOfEachPart*2, :);
% the fifteenth area
area15 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, colsOfEachPart*2+1:colsOfEachPart*3, :);

% the sixteenth area
area16 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, colsOfEachPart*3+1:colsOfEachPart*4, :);
% the seventeenth area
area17 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, colsOfEachPart*4+1:colsOfEachPart*5, :);
% the eighteenth area
area18 = image(rowsOfEachPart*2+1:rowsOfEachPart*3, colsOfEachPart*5+1:cols, :);
% the nineteenth area
area19 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, 1:colsOfEachPart, :);
% the twentieth area
area20 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, colsOfEachPart+1:colsOfEachPart*2, :);

% the twenty-first area
area21 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, colsOfEachPart*2+1:colsOfEachPart*3, :);
% the twenty-second area
area22 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, colsOfEachPart*3+1:colsOfEachPart*4, :);
% the twenty-third area
area23 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, colsOfEachPart*4+1:colsOfEachPart*5, :);
% the twenty-fourth area
area24 = image(rowsOfEachPart*3+1:rowsOfEachPart*4, colsOfEachPart*5+1:cols, :);
% the twenty-fifth area
area25 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, 1:colsOfEachPart, :);

% the twenty-sixth area
area26 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, colsOfEachPart+1:colsOfEachPart*2, :);
% the twenty-seventh area
area27 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, colsOfEachPart*2+1:colsOfEachPart*3, :);
% the twenty-eighth area
area28 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, colsOfEachPart*3+1:colsOfEachPart*4, :);
% the twenty-ninth area
area29 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, colsOfEachPart*4+1:colsOfEachPart*5, :);
% the thirtieth area
area30 = image(rowsOfEachPart*4+1:rowsOfEachPart*5, colsOfEachPart*5+1:cols, :);


% ROW 1
% the area1 will be converted to red color
area1(:,:,2) = 0;
area1(:,:,3) = 0;
% the area2 will be converted to red
area2(:,:,2) = 0;
area2(:,:,3) = 0;
% the area3 will be converted to blue
area3(:,:,1) = 0;
area3(:,:,2) = 0;
% the area4 will be converted to blue
area4(:,:,1) = 0;
area4(:,:,2) = 0;
% the area5 will be converted to green
area5(:,:,1) = 0;
area5(:,:,3) = 0;
% the area6 will be converted to green
area6(:,:,1) = 0;
area6(:,:,3) = 0;

% ROW 2
% the area7 will be converted to red
area7(:,:,2) = 0;
area7(:,:,3) = 0;
% the area8 will be converted to blue
area8(:,:,1) = 0;
area8(:,:,2) = 0;
% the area9 will be converted to black
area9(:,:,1) = 0;
area9(:,:,2) = 0;
area9(:,:,3) = 0;
% the area10 will be converted to black
area10(:,:,1) = 0;
area10(:,:,2) = 0;
area10(:,:,3) = 0;
% the area11 will be converted to blue
area11(:,:,1) = 0;
area11(:,:,2) = 0;
% the area12 will be converted to green
area12(:,:,1) = 0;
area12(:,:,3) = 0;


% ROW 3
% the area13 will be converted to red
area13(:,:,2) = 0;
area13(:,:,3) = 0;
% the area14 will be converted to blue
area14(:,:,1) = 0;
area14(:,:,2) = 0;
% the area15 will be converted to blue
area15(:,:,1) = 0;
area15(:,:,2) = 0;
% the area16 will be converted to blue
area16(:,:,1) = 0;
area16(:,:,2) = 0;
% the area17 will be converted to blue
area17(:,:,1) = 0;
area17(:,:,2) = 0;
% the area18 will be converted to green
area18(:,:,1) = 0;
area18(:,:,3) = 0;

% ROW 4
% the area19 will be converted to red
area19(:,:,2) = 0;
area19(:,:,3) = 0;
% the area20 will be converted to blue
area20(:,:,1) = 0;
area20(:,:,2) = 0;
% the area21 will be converted to black
area21(:,:,1) = 0;
area21(:,:,2) = 0;
area21(:,:,3) = 0;
% the area22 will be converted to black
area22(:,:,1) = 0;
area22(:,:,2) = 0;
area22(:,:,3) = 0;
% the area23 will be converted to blue
area23(:,:,1) = 0;
area23(:,:,2) = 0;
% the area24 will be converted to green
area24(:,:,1) = 0;
area24(:,:,3) = 0;

% ROW 5
% the area25 will be converted to red
area25(:,:,2) = 0;
area25(:,:,3) = 0;
% the area26 will be converted to blue
area26(:,:,1) = 0;
area26(:,:,2) = 0;
% the area27 will be converted to black
area27(:,:,1) = 0;
area27(:,:,2) = 0;
area27(:,:,3) = 0;
% the area28 will be converted to black
area28(:,:,1) = 0;
area28(:,:,2) = 0;
area28(:,:,3) = 0;
% the area29 will be converted to blue
area29(:,:,1) = 0;
area29(:,:,2) = 0;
% the area30 will be converted to green
area30(:,:,1) = 0;
area30(:,:,3) = 0;


% SHOW THE RESULT 
% show all the areas in a subplot matrix
figure(1);
subplot(5,6,1), imshow(area1);
subplot(5,6,2), imshow(area2);
subplot(5,6,3), imshow(area3);
subplot(5,6,4), imshow(area4);
subplot(5,6,5), imshow(area5);
subplot(5,6,6), imshow(area6);
subplot(5,6,7), imshow(area7);
subplot(5,6,8), imshow(area8);
subplot(5,6,9), imshow(area9);
subplot(5,6,10), imshow(area10);
subplot(5,6,11), imshow(area11);
subplot(5,6,12), imshow(area12);
subplot(5,6,13), imshow(area13);
subplot(5,6,14), imshow(area14);
subplot(5,6,15), imshow(area15);
subplot(5,6,16), imshow(area16);
subplot(5,6,17), imshow(area17);
subplot(5,6,18), imshow(area18);
subplot(5,6,19), imshow(area19);
subplot(5,6,20), imshow(area20);
subplot(5,6,21), imshow(area21);
subplot(5,6,22), imshow(area22);
subplot(5,6,23), imshow(area23);
subplot(5,6,24), imshow(area24);
subplot(5,6,25), imshow(area25);
subplot(5,6,26), imshow(area26);
subplot(5,6,27), imshow(area27);
subplot(5,6,28), imshow(area28);
subplot(5,6,29), imshow(area29);
subplot(5,6,30), imshow(area30);