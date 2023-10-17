clc
warning off all

% Leer la imagen peppers.png y almacenarla en la variable image
image = imread('peppers.png');

% Obtener el tamaño de la imagen
[rows, columns, numberOfColorChannels] = size(image);

% define un arreglo de 4 elementos para colocar la misma imagen en 4 diferentes escalas
imageArray = cell(1,4);

% En la primera posicion del arreglo coloca la imagen en escala de grises
imageArray{1} = rgb2gray(image);

% En la segunda posicion del arreglo coloca la imagen pero despues de apagar las componentes rojo y azul
imageArray{2} = image;
imageArray{2}(:,:,1) = 0;
imageArray{2}(:,:,3) = 0;

% En la segunda posicion del arreglo coloca la imagen pero despues de apagar las componentes verde y azul
imageArray{3} = image;
imageArray{3}(:,:,2) = 0;
imageArray{3}(:,:,3) = 0;

% En la segunda posicion del arreglo coloca la imagen pero despues de apagar las componentes rojo
imageArray{4} = image;
imageArray{4}(:,:,1) = 0;

% muestra las iamgenes en una ventana acomodandolas en 2 filas y 2 columnas. no uses subplot
figure, montage(imageArray, 'Size', [2 2]);

% muestra la figura actual en pantalla completa
set(gcf, 'Position', get(0, 'Screensize'));

