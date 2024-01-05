import os
import shutil

# Ruta de la carpeta que contiene las imágenes que deseas renombrar
carpeta_imagenes = './images'

# Obtén la lista de archivos en la carpeta
archivos = os.listdir(carpeta_imagenes)

# Inicializa un contador
contador = 1

# Itera sobre los archivos en la carpeta
for archivo in archivos:
    # Verifica si el archivo es una imagen (puedes agregar más extensiones si es necesario)
    if archivo.endswith(('.jpg', '.jpeg', '.png', '.gif')):
        # Crea el nuevo nombre de archivo con el formato "imagen_1.jpg"
        nuevo_nombre = f'img_{contador}.jpg'
        
        # Ruta completa del archivo original y nuevo
        ruta_original = os.path.join(carpeta_imagenes, archivo)
        ruta_nueva = os.path.join(carpeta_imagenes, nuevo_nombre)
        
        # Renombra el archivo
        shutil.move(ruta_original, ruta_nueva)
        
        # Incrementa el contador
        contador += 1

print("Imágenes renombradas exitosamente.")
