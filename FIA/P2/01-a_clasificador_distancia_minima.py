import pandas as pd
import numpy as np

# Lee el dataset
dataset = pd.read_csv('dataset_iris.csv')

# Calcula el promedio por cada clase y por cada propiedad
promedios = dataset.groupby('clase').mean()

# Imprime los promedios
print("Promedio por clase y propiedad:")
print(promedios)
print("\n")

""" # Entrada de texto para hacer pruebas
entrada_prueba = input("\nIngrese los valores para la prueba (largo_sepalo, ancho_sepalo, largo_petalo, ancho_petalo): ")
valores_prueba = [float(valor) for valor in entrada_prueba.split(',')]

# Calcula las distancias mínimas y encuentra la clase más cercana
distancias = np.sqrt(np.sum((promedios.values - valores_prueba)**2, axis=1))
clase_predicha = promedios.index[np.argmin(distancias)]

# Imprime la clase predicha
print("\nClase predicha para la entrada de prueba:", clase_predicha)
 """
 
# utiliza los datos del dataset para hacer las pruebas  y verificar si pertenece o no a la clase
for i in range(len(dataset)):    
    # ibtener los valores de prueba y parsealos a flaot
    valores_prueba = dataset.iloc[i, 0:4].values
    # parse to float
    valores_prueba = valores_prueba.astype(float)
    print("Valores de prueba:", valores_prueba)
    clase_real = dataset.iloc[i, 4]
    print("Clase real:", clase_real)
    distancias = np.sqrt(np.sum((promedios.values - valores_prueba)**2, axis=1))
    print("Distancias:", distancias)
    clase_predicha = promedios.index[np.argmin(distancias)]
    print("Clase predicha para la entrada de prueba:", clase_predicha, "Clase real:", clase_real)
    if clase_predicha == clase_real:
        print("Si pertenece a la clase")
    else:
        print("No pertenece a la clase")
    print("")