clc
correccion_hamming()

function correccion_hamming()
    % Leer el archivo
    fid = fopen('codificacion.txt', 'r');
    if fid == -1
        error('No se pudo abrir el archivo.');
    end
    contenido = fscanf(fid, '%s');
    fclose(fid);
    
    % Convertir la cadena a un array de números
    data = str2num(contenido(:))';

    % Comprobar y corregir errores
    [data_corregida, bit_error] = detectar_corregir_hamming(data);

    % Mostrar y guardar los resultados
    if bit_error == 0
        disp('No se encontraron errores.');
    else
        fprintf('Error encontrado y corregido en el bit %d.\n', bit_error);
    end
    
    % Guardar la cadena corregida
    fid = fopen('codificacion.txt', 'w');
    fprintf(fid, '%d', data_corregida);
    fclose(fid);
end

function [data_corregida, bit_error] = detectar_corregir_hamming(data)
    n = length(data);
    r = 1;
    
    % Calcular el número de bits de redundancia necesarios
    while 2^r < (n + r + 1)
        r = r + 1;
    end
    
    % Calcular posiciones de los bits de redundancia
    parity_bits = zeros(1, r);
    for i = 1:r
        parity_bits(i) = 2^(i-1);
    end
    
    % Calcular los bits de paridad
    bit_error = 0;
    for i = 1:r
        parity = 0;
        for j = 1:n
            if bitand(j, 2^(i-1))
                parity = xor(parity, data(j));
            end
        end
        bit_error = bit_error + parity * 2^(i-1);
    end
    
    % Corregir el error si existe
    data_corregida = data;
    if bit_error ~= 0
        data_corregida(bit_error) = ~data_corregida(bit_error);
    end
end
