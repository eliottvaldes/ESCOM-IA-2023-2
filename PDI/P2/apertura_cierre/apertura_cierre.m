% programa para realizar la apertura y cierre de una imagen 
% para la apertura se requiere erocion y dilatacion
% para el cierre se requiere dilatacion y erocion

% al usuario se le pide:
% solicitar que operacion quiere realizar: apertura o cierre
% solicitar el tamaño del kernel: (el minimo es 3)

% implementar la erocion y dilatacion con ciclos for

morfologia_imagen()

function morfologia_imagen()
    % Solicitar al usuario la operación a realizar
    operacion = input('Ingrese la operacion a realizar (apertura/cierre): ', 's');
    % Solicitar el tamaño del kernel
    tam_kernel = input('Ingrese el tamaño del kernel (minimo 3): ');
    if tam_kernel < 3
        disp('El tamaño del kernel debe ser al menos 3.');
        return;
    end
    
    % Leer una imagen
    img = imread('peppers.png'); % Reemplazar con la ruta de la imagen deseada
    img = rgb2gray(img); % Convertir a escala de grises si es necesario
    img = imbinarize(img);

    % Crear el kernel
    kernel = ones(tam_kernel, tam_kernel);

    % Realizar la operación seleccionada
    switch operacion
        case 'apertura'
            img_result = dilatacion(erosion(img, kernel), kernel);
        case 'cierre'
            img_result = erosion(dilatacion(img, kernel), kernel);
        otherwise
            disp('Operación no válida.');
            return;
    end

    % Mostrar la imagen original y el resultado
    figure;
    subplot(1,2,1); imshow(img); title('Imagen Original');
    subplot(1,2,2); imshow(img_result); title(['Resultado de ' operacion]);
end

% Función de erosión
function result = erosion(image, kernel)
    %Se obtienen las medidas de la imagen y del kernel
    [m, n] = size(image);
    [km, kn] = size(kernel);
    %Se crea una matriz, con la imagen original adentro y los bordes llenos
    %de ceros para evitar errores en los calculos de los pixeles de los
    %bordes
    pad_height = (km - 1) / 2;
    pad_width = (kn - 1) / 2;
    padded_image = zeros(m + 2 * pad_height, n + 2 * pad_width);
    padded_image(pad_height + 1:m + pad_height, pad_width + 1:n + pad_width) = image;

    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            %Se selecciona un pedazo de la imagen del tanaño del kernel
            patch = padded_image(i:i + km - 1, j:j + kn - 1);
            %Devuelve el valor minimo donde el kernel=1
            result(i, j) = min(patch(kernel == 1));
        end
    end
end


% Función de dilatación
function result = dilatacion(image, kernel)
    [m, n] = size(image);
    [km, kn] = size(kernel);
    
    pad_height = (km - 1) / 2;
    pad_width = (kn - 1) / 2;
    
    padded_image = zeros(m + 2 * pad_height, n + 2 * pad_width);
    padded_image(pad_height + 1:m + pad_height, pad_width + 1:n + pad_width) = image;

    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            patch = padded_image(i:i + km - 1, j:j + kn - 1);
            result(i, j) = max(patch(kernel == 1));
        end
    end
end