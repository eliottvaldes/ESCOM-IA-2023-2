clc; warning off all; clear; close all;

% Define el directorio donde se encuentran las imagenes
folderPath = './images';
objectsPath = './imagesObjects';

images = dir(fullfile(folderPath, '*.jpg'));


% Procesar cada imagen
for i = 1:length(images)
    imagePath = fullfile(folderPath, images(i).name);

    I = imread(imagePath);

    newWidth = size(I, 2) * 0.2;
    newHeigth  = size(I, 1) * 0.2;
    I = imresize(I, [newHeigth, newWidth], 'bicubic');
    I = im2double(I);
    original = I;

    filter_parks = firpm(16, [0 0.1 0.4 1], [0 0 1 1]);
    filter_parks = ftrans2(filter_parks);
    I_filtered = filter2(filter_parks, rgb2gray(I));
    I = I + I_filtered;

    imagen_saturada = I * 1.1;
    I = min(max(imagen_saturada, 0), 1);

    I = im2gray(I);

    I = wiener2(I, [5 5]);
    I = imbinarize(I);

    I = bwareaopen(I, 900);

    SE = strel('arbitrary', 10);
    I = imclose(I, SE);

    I = bwareaopen(I, 500);

    SE = strel('disk', 6, 8);
    I = imerode(I, SE);

    I = I == 0;

    [L, num] = bwlabel(I);
    propiedades = regionprops(L, 'Area');
    I_filtrada = false(size(I));
    for k = 1:num
        if propiedades(k).Area >= 2000 && propiedades(k).Area < 19000
            I_filtrada = I_filtrada | (L == k);
        end
    end
    I = I_filtrada;

    [B, L] = bwboundaries(I, 8, "holes");


    objetos = label2rgb(L, @jet, [.5 .5 .5]);
    fig = figure;
    imshowpair(original, objetos, "montage");
    title("Imagen original y bordes");
    [~, imageName, ~] = fileparts(images(i).name);
    savePath = fullfile(objectsPath, [imageName '.jpg']);
    saveas(fig, savePath);
    close(fig);

end