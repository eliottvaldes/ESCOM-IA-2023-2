clc
clear all
close all

% load the image
%figure(1)

% read the image
h = imread('peppers.png');
% show the image
% imshow(h);

% save the coords
[n,m] = size(h);


% define a second image
figure(2)
% read the image using the imref2d function to change the coords into the
% function 'imref2d' is used especificaly to change the coords of the image
dato = imref2d(size(h)); 
imshow(h,dato)


% select the classes in the image

% CLASS SKY
% create random nums to get the coords of the class 'sky'
c1x = randi([1, 502],1,100); % create 10 random nums between 1 and 110
c1y = randi([1, 110],1,100); % create 10 random nums between 1 and 502
% graph the points in the image pixel coords
z1 = impixel(h,c1x(1,:), c1y(1,:)); % get the pixel coords of the image
% create an array with the points
c1 = [c1x; c1y];

% CLASS OCEAN
% create random number to coords of the class 'ocean'
c2x = randi([1, 502],1,100); % create 10 random nums between 1 and 110
c2y = randi([115, 160],1,100); % create 10 random nums between 1 and 502
% graph the points in the image pixel coords
z2 = impixel(h,c2x(1,:), c2y(1,:)); % get the pixel coords of the image
% create an array with the points
c2 = [c2x; c2y];

% CLASS ROCK
% create the random  numbers to the class 'rock'
c3x = randi([250, 450],1,100); % create 10 random nums between 1 and 110
c3y = randi([160, 310],1,100); % create 10 random nums between 1 and 502
% graph the points in the image pixel coords
z3 = impixel(h,c3x(1,:), c3y(1,:)); % get the pixel coords of the image
% create an array with the points
c3 = [c3x; c3y];

% RANDOM POINT 
% ask for the coords fot the point to match with the classes
px = input('Enter the x coord: ');
py = input('Enter the y coord: ');
% define a point
p = [px, py];
% get the pixel coords of the point
zp = impixel(h,px(1,:), py(1,:));


% plot the points in the image
grid on % show the grid
hold on % hold the plot

% plot the points in the image of class 'sky'
plot(c1x(1,:), c1y(1,:), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
% plot the points in the image of class 'ocean'
plot(c2x(1,:), c2y(1,:), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b')
% plot the points in the image of class 'rock'
plot(c3x(1,:), c3y(1,:), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g')
% plot the point to match
plot(px(1,:), py(1,:), 'mo', 'MarkerSize', 10, 'MarkerFaceColor', 'm')


legend('sky', 'ocean', 'rock', 'point to match')



% define the mean of each class
% mean of the class 'sky'
m1 = mean(z1);
% mean of the class 'ocean'
m2 = mean(z2);
% mean of the class 'rock'
m3 = mean(z3);

% get the distance between the point to match and the mean of each class using norm
% distance between the point to match and the mean of the class 'sky'
d1 = norm(zp - m1);
% distance between the point to match and the mean of the class 'ocean'
d2 = norm(zp - m2);
% distance between the point to match and the mean of the class 'rock'
d3 = norm(zp - m3);


% get the min distance of point to match and the mean of each class
min_distance = min([d1, d2, d3]);

% get the class of the point to match
if min_distance == d1
    disp('The point to match is in the class sky')
elseif min_distance == d2
    disp('The point to match is in the class ocean')
elseif min_distance == d3
    disp('The point to match is in the class rock')
end



disp('End of the program')