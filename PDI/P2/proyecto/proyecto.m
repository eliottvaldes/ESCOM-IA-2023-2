% proyecto de PDI
clc, warning off all, close all;
% obtener la imagen
original = imread("images/img_2.jpg");
figure(1), subplot(3,3,2), imshow(original), title("Original");

% obtenemos escala de grises
I = im2gray(original);
%figure;
%imshow(I);

% suavizamos el ruido dentro de la imagen
I= wiener2(I, [5 5]);

I = imbinarize(I);
subplot(3,3,4), imshow(I), title("Binarizada");


% seguimos eliminando ruido
% eliminamos las regiones que tengan menos de 400 px
I = bwareaopen(I, 200, 4);
%figure;
%imshow(I);

%SE = strel("diamond", 3);
% aplicamos erosión de la imagen
% I= imdilate(I, SE);
% I = imerode(I, SE);


% rellenamos espacio en objetos
SE = strel('arbitrary', 10);
%SE = strel("diamond", 3);
I = imclose(I, SE);
subplot(3,3,5), imshow(I), title("Rellenado de espacios con cierre de imagen");


% rellenamos espacio en objetos
SE = strel('disk', 6);
I = imerode(I, SE);
subplot(3,3,6) ,imshow(I), title("Con erosion");

% Rellenar los espacios en blanco en la imagen binaria
I = imfill(I, "holes");
figure(2),imshow(I), title("Rellenando espacios en blanco");




% % usamos contornos exteriores para caracterizar cada objeto
% [B, L] = bwboundaries(I, 4, "holes");
%
% % test
% figure;
% imshowpair(original, L, "montage");
% title("Imagen original y bordes");
% % end test
%
% figure;
% imshow(label2rgb(L, @jet, [.5 .5 .5]))
% title("Bordes indetificados");
%
% hold on
% % for k = 1: length(B)    boundary = B(k); % ciclo para dibujar los contornos de las regiones
% %     plot(boundary(:,2),'w','LineWidth',2)
% % end
%
% % obtenemos la caracterizacion de la imagen
% stats = regionprops(L, 'Area', 'Centroid');
% threshold = 0.94;
% for k =1:length(B)
%     boundary = B(k);
%     delta_sq = diff(boundary).^2;
%     % obtenemos el perimetro
%     perimeter = sum(sqrt(sum(delta_sq, 2)));
%     % obtenemos el area
%     area = stats(k).Area;
%     % obtenemos la metrica usando el area y perimetro
%     metric = 4*pi*area/perimeter^2;
%     % asignamos metrica a cada region
%     metric_string = sprintf('%2.2f', metric);
%     if metric > threshold
%         % obtenemos el centroide
%         centroid = stats(k).Centroid;
%         % lo dibujamos en pantalla
%         plot(centroid(1), centroid(2), 'ko');
%     end
%     text(boundary(1,2)-35, boundary(1,1)+13, metric_string, 'Color', 'k', 'FontSize', 20, 'FontWeight', 'bold')
% end
