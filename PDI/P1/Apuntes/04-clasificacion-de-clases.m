clc
close all
warning off all

a = imread('peppers.png'); % read image
% figure(1) % create new figure

figure(2) % create new figure
classes = impixel(a) % display image pixel values and return pixel values in classes
% impixel ayuda a ver los valores de los pixeles de la imagen
% se puede seleccionar un pixel y ver su valor al dar enter

% get the clase_one suppose to click 10 times
class_one = classes(1:3,:) % get the first class => first 3 rows and all columns
class_two = classes(4:6,:) % get the second class => 4th to 6th rows and all columns
class_three = classes(7:10,:) % get the third class => 7th to 10th rows and all columns

% get the unknown value
unknown_class = classes(10,:) % get the unknown class => 10th row and all columns

% get the mean of each class and each column
mean_class_one = mean(class_one) % get the mean of the first class
mean_class_two = mean(class_two) % get the mean of the second class
mean_class_three = mean(class_three) % get the mean of the third class 


% get the distance between the unknown class and the first class
distance_class_one = sqrt(sum((unknown_class - mean_class_one).^2)) % get the distance between the unknown class and the first class
distance_class_two = sqrt(sum((unknown_class - mean_class_two).^2)) % get the distance between the unknown class and the second class
distance_class_three = sqrt(sum((unknown_class - mean_class_three).^2)) % get the distance between the unknown class and the third class

% another way to get the distance is just
% distance_class_one = norm(unknown_class - mean_class_one) % get the distance between the unknown class and the first class
% distance_class_two = norm(unknown_class - mean_class_two) % get the distance between the unknown class and the second class
% distance_class_three = norm(unknown_class - mean_class_three) % get the distance between the unknown class and the third class

% another way to get the min distance is find the min value of the vector
% distances = [distance_class_one distance_class_two distance_class_three];
% min_distance = min(min(distances))
%class = find(distances == min_distance)

% get the minimum distance
min_distance = min([distance_class_one distance_class_two distance_class_three]); % get the minimum distance

% get the class of the minimum distance
if min_distance == distance_class_one
    class = 'Pimiento verde'
elseif min_distance == distance_class_two
    class = 'Cebollin'
elseif min_distance == distance_class_three
    class = 'Pimiento rojo'
end


