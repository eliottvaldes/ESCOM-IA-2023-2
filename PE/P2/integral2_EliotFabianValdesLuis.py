# Eliot Fabian Valdes Luis
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad
from scipy.stats import norm

# Definición de la función gaussiana
def gaussian_function(x):
    """Calcula el valor de la función gaussiana para un valor de x dado.

    Args:
        x (float): Punto en el que se evalúa la función gaussiana.

    Returns:
        float: Valor de la función gaussiana en x.
    """
    return norm.pdf(x, 0, 1)

# Solicitar al usuario el límite superior de integración
upper_limit = float(input("Ingresa el límite superior de integración (b): "))

# Parámetros de integración
initial_point = -6  # Punto de inicio
increment = 0.01   # Incremento para cada paso de integración

# Inicialización de variables
current_point = initial_point
accumulated_integral_values = []

# Bucle para calcular la integral acumulativa
while current_point < upper_limit:
    current_point = round(current_point + increment, 2)
    integral_value = quad(gaussian_function, initial_point, current_point)[0]
    accumulated_integral_values.append(integral_value)
    print(f"b = {current_point:.2f}, Integral acumulada = {integral_value:.50f}")