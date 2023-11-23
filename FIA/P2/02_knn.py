import pandas as pd
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

# Lee el dataset
dataset = pd.read_csv('dataset_iris.csv')

# Separar las características y las etiquetas
X = dataset.iloc[:, :-1].values  # Características
y = dataset.iloc[:, -1].values   # Etiquetas de clase

# Crear el modelo k-NN
k = 1
knn = KNeighborsClassifier(n_neighbors=k)

# Entrenar el modelo con los datos
knn.fit(X, y)

# Utiliza los datos del dataset para hacer las pruebas y verificar si pertenece o no a la clase
for i in range(len(dataset)):
    valores_prueba = dataset.iloc[i, 0:4].values
    valores_prueba = valores_prueba.reshape(1, -1)  # Redimensionar para la predicción
    clase_real = dataset.iloc[i, 4]

    # Realiza la predicción usando k-NN
    clase_predicha = knn.predict(valores_prueba)[0]

    print(f"Valores de prueba: {valores_prueba.flatten()}")
    print(f"Clase real: {clase_real}")
    print(f"Clase predicha para la entrada de prueba: {clase_predicha}")

    # Verificar si la clase predicha coincide con la clase real
    if clase_predicha == clase_real:
        print("+ Si pertenece a la clase")
    else:
        print("- No pertenece a la clase")
    print("")
