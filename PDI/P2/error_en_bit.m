clc
hamming_correction()

% 1010111001


function hamming_correction()
    % Leer el archivo
    fileID = fopen('codificacion.txt', 'r');
    encoded_str = fgetl(fileID);
    fclose(fileID);
    
    % Convertir la cadena en un vector de bits
    encoded_bits = double(encoded_str) - '0';

    % Longitud de los datos (sin incluir los bits de paridad)
    data_length = length(encoded_bits) - sum(2.^(0:floor(log2(length(encoded_bits)))));
    
    % Detectar y corregir errores
    [corrected_bits, error_bit] = detect_and_correct_hamming(encoded_bits, data_length);

    % Mostrar la posición del error
    if error_bit == 0
        disp('No se encontró error.');
    else
        disp(['Error encontrado en el bit: ', num2str(error_bit)]);
    end

    % Guardar los datos corregidos
    fileID = fopen('codificacion.txt', 'w');
    fprintf(fileID, '%d', corrected_bits);
    fclose(fileID);
end

function [corrected_bits, error_bit] = detect_and_correct_hamming(encoded_bits, data_length)
    n = length(encoded_bits);
    corrected_bits = encoded_bits;
    error_bit = 0;
    
    % Revisar cada bit de paridad
    for i = 1:log2(n+1)
        parity_index = 2^(i-1);
        parity_sum = 0;
        
        % Sumar los bits para los cuales este bit de paridad es responsable
        for j = 1:n
            if bitand(j, parity_index)
                parity_sum = parity_sum + encoded_bits(j);
            end
        end
        
        % Comprobar si la paridad es impar
        if mod(parity_sum, 2) ~= 0
            error_bit = error_bit + parity_index;
        end
    end
    
    % Corregir el error si se encuentra
    if error_bit ~= 0
        corrected_bits(error_bit) = mod(corrected_bits(error_bit) + 1, 2);
    end
end
