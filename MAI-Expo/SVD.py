from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import svd

# Cargar la imagen proporcionada por el usuario
file_path = './images/salchicha.jpg'
original_image = Image.open(file_path)

# Convertir la imagen a escala de grises
gray_image = original_image.convert("L")

# Convertir la imagen en escala de grises a una matriz
image_matrix = np.array(gray_image)

# Aplicar SVD a la matriz de la imagen
U, S, VT = svd(image_matrix)

# mostramos los calores de U, S y VT
print("U:", U.shape)
print("S:", S.shape)
print("VT:", VT.shape)


# Mostrar los primeros 5 valores singulares para dar una idea de su magnitud
print("Primeros 5 valores singulares:", S[:5])

# Vamos a reconstruir la imagen usando diferentes números de valores singulares
# para observar el efecto de la compresión
components = [2, 5, 15, 30, 50]  # Número de componentes singulares a usar para la reconstrucción

# Función para reconstruir la imagen con un número específico de componentes
def reconstruct_image(U, S, VT, k):
    # Tomar las primeras 'k' componentes
    Uk = U[:, :k]
    Sk = np.diag(S[:k])
    VTk = VT[:k, :]

    # Reconstruir la imagen
    return np.dot(Uk, np.dot(Sk, VTk))

# Reconstruir y mostrar las imágenes comprimidas
plt.figure(figsize=(10, 6))
plt.subplot(1, len(components) + 1, 1)
plt.imshow(image_matrix, cmap='gray')
plt.title("Original")
plt.axis('off')

for i, k in enumerate(components):
    compressed_image = reconstruct_image(U, S, VT, k)
    plt.subplot(1, len(components) + 1, i+2)
    plt.imshow(compressed_image, cmap='gray')
    plt.title(f"{k} Comp.")
    plt.axis('off')

plt.show()
