import pandas as pd
import numpy as np
from scipy.sparse.linalg import svds

# Cargar datos (asumiendo que ya están limpios)
# Reemplazar 'path_to_dataset.csv' con la ruta de tu archivo CSV
df = pd.read_csv('./files/calificaciones_peliculas.csv')

# 1. Crear una Matriz Usuario-Película
matriz_calificaciones = df.pivot(index='Usuario', columns='Pelicula', values='Calificacion').fillna(0)

# 2. Aplicar SVD
# Convertir a array de numpy
matriz_calificaciones_np = matriz_calificaciones.to_numpy()

# Centrar los datos restando la media de las calificaciones
media_calificaciones = np.mean(matriz_calificaciones_np, axis=1)
matriz_calificaciones_demeaned = matriz_calificaciones_np - media_calificaciones.reshape(-1, 1)

# Realizar SVD
U, sigma, Vt = svds(matriz_calificaciones_demeaned, k=20)  # k es el número de valores singulares a mantener

# 3. Reducir Dimensionalidad
sigma = np.diag(sigma)

# 4. Realizar Predicciones
predicciones_calificaciones = np.dot(np.dot(U, sigma), Vt) + media_calificaciones.reshape(-1, 1)
predicciones_df = pd.DataFrame(predicciones_calificaciones, columns=matriz_calificaciones.columns)

# Función para recomendar películas
def recomendar_peliculas(predicciones_df, usuario_id, peliculas_df, calificaciones_originales_df, num_recomendaciones=5):
    # Obtener y ordenar las predicciones del usuario
    usuario_row_number = predicciones_df.index.get_loc(usuario_id)
    sorted_user_predictions = predicciones_df.iloc[usuario_row_number].sort_values(ascending=False)

    # Obtener los datos del usuario original
    usuario_datos = calificaciones_originales_df[calificaciones_originales_df.Usuario == usuario_id]
    usuario_visto = usuario_datos.set_index('Pelicula').join(peliculas_df).sort_values(['Calificacion'], ascending=False)

    # Recomendar las películas de mayor puntaje que el usuario aún no ha visto
    recomendaciones = peliculas_df[~peliculas_df['Pelicula'].isin(usuario_visto['Pelicula'])].merge(
      pd.DataFrame(sorted_user_predictions).reset_index(), how='left', left_on='Pelicula', right_on='Pelicula'
    ).rename(columns={usuario_row_number: 'Predicciones'}).sort_values('Predicciones', ascending=False)

    return recomendaciones.iloc[:num_recomendaciones, :-1]

# Ejemplo de uso
usuario_ejemplo = 'Usuario_1'
recomendaciones = recomendar_peliculas(predicciones_df, usuario_ejemplo, df, df, 5)
print(recomendaciones)
