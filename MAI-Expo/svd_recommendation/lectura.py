import pandas as pd
import time

start_time = time.time()

# Crea una lista vacía para almacenar los datos
data = []
# Abre el archivo reviews.txt y léelo línea por línea
with open('./files/lthing_data/reviews.txt', 'r', encoding='utf-8') as file:
    for line in file:
        try:
            # Divide la línea en partes usando '=' como separador
            parts = line.strip().split('=')
            if len(parts) == 2:
                # Extrae el usuario, la obra y las estrellas de cada revisión
                review_info = eval(parts[1])            
                user = review_info['user'] if 'user' in review_info else None
                work = review_info['work'] if 'work' in review_info else None
                stars = review_info['stars'] if 'stars' in review_info else None
                if user and work and stars:
                    # Almacena la información en un diccionario
                    data.append({'user': user, 'work': work, 'stars': stars})                
        except Exception as e:
            print(e)
            
            

# Crea un DataFrame a partir de la lista de diccionarios
df = pd.DataFrame(data)

end_time = time.time()

print("Tiempo de ejecución: ", end_time - start_time)

# mostrar la longitud del DataFrame
print(len(df))

# Muestra el DataFrame
print(df)




# Convertir la lista de reseñas en un DataFrame y mostrar algunos ejemplos.
reviews = pd.DataFrame(reviews, columns=["user", "work", "stars"])
print(reviews.head())

# Análisis de usuarios y libros populares.
# Contar cuántos libros ha reseñado cada usuario.
usercount = reviews[["work","user"]].groupby("user").count()
usercount = usercount[usercount["work"] >= 50]

# Contar cuántos usuarios han reseñado cada libro.
workcount = reviews[["work","user"]].groupby("work").count()
workcount = workcount[workcount["user"] >= 50]

# Filtrar para mantener solo usuarios y libros populares.
reviews = reviews[reviews["user"].isin(usercount.index) & reviews["work"].isin(workcount.index)]
print("\nSubset of data:")
print(reviews)

# Convertir reseñas en una matriz usuario-libro, llenando valores faltantes con cero.
reviewmatrix = reviews.pivot(index="user", columns="work", values="stars").fillna(0)
matrix = reviewmatrix.values

# Realizar descomposición en valores singulares (SVD) de la matriz de reseñas.
u, s, vh = np.linalg.svd(matrix, full_matrices=False)

# Función para calcular la similitud de coseno entre dos vectores.
def cosine_similarity(v, u):
    return (v @ u) / (np.linalg.norm(v) * np.linalg.norm(u))

# Encontrar la mayor similitud de coseno entre libros.
highest_similarity = -np.inf
highest_sim_col = -1
for col in range(1, vh.shape[1]):
    similarity = cosine_similarity(vh[:,0], vh[:,col])
    if similarity > highest_similarity:
        highest_similarity = similarity
        highest_sim_col = col

# Imprimir el resultado mostrando qué libro es más similar al primero.
print("Column %d (book id %s) is most similar to column 0 (book id %s)" %
      (highest_sim_col, reviewmatrix.columns[col], reviewmatrix.columns[0])
)