import pandas as pd
import numpy as np
from scipy.sparse.linalg import svds

# obtener los datos del archivo csv
data = pd.read_csv('./files/calificaciones_peliculas.csv')

df = pd.DataFrame(data)

# Transformar los datos en una matriz usuario-película
R_df = df.pivot(index='Usuario', columns='Pelicula', values='Calificacion').fillna(0)

# Convertir a matriz numpy
R = R_df.to_numpy()

# Normalizar quitando la media de las calificaciones de cada usuario
user_ratings_mean = np.mean(R, axis=1)
R_demeaned = R - user_ratings_mean.reshape(-1, 1)

# Aplicar SVD
U, sigma, Vt = svds(R_demeaned, k=min(R_demeaned.shape)-1)

# Convertir sigma en una matriz diagonal
sigma = np.diag(sigma)

# Hacer predicciones de calificaciones
predicted_ratings = np.dot(np.dot(U, sigma), Vt) + user_ratings_mean.reshape(-1, 1)

# Convertir las predicciones a un DataFrame
preds_df = pd.DataFrame(predicted_ratings, columns=R_df.columns)

# Mostrar los primeros elementos de la matriz de predicciones
print(preds_df.head())


