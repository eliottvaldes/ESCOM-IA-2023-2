import pandas as pd
import numpy as np
import random

# Parámetros
num_usuarios = 100
num_peliculas = 50
max_calificacion = 5

# Crear IDs de usuario y película
usuarios = [f'Usuario_{i+1}' for i in range(num_usuarios)]
peliculas = [f'Pelicula_{j+1}' for j in range(num_peliculas)]

# Generar calificaciones
data = []
for usuario in usuarios:
    for pelicula in peliculas:
        # Asumir que un usuario no califica todas las películas
        if random.random() < 0.7:  # 70% de probabilidad de que el usuario haya calificado la película
            calificacion = random.randint(1, max_calificacion)
            data.append([usuario, pelicula, calificacion])

# Crear DataFrame
df = pd.DataFrame(data, columns=['Usuario', 'Pelicula', 'Calificacion'])

# Guardar en CSV
df.to_csv('./files/calificaciones_peliculas.csv', index=False)

# Mostrar los primeros registros del DataFrame
df.head()
