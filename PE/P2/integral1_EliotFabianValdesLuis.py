# Eliot Fabian Valdes Luis
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from scipy.integrate import quad

# Solicitar al usuario los parámetros de la distribución gaussiana
""" a_limit = float(input("Ingrese el valor de a: "))
b_limit = float(input("Ingrese el valor de b: "))
mu_value = float(input("Ingrese el valor de mu: "))
sigma_value = float(input("Ingrese el valor de sigma: ")) """

## valdiarte if b is a number or inf
# if user enter a number, b = b_limit
# if user enter 'inf', inf = mu_value + 6*sigma_value
# if user enter '-inf', -inf = mu_value - 6*sigma_value
a_limit = 20
b_limit = 'inf'
mu_value = 23
sigma_value = 5

# validate the value of b_limit
if b_limit == 'inf':
    b_limit = mu_value + 6*sigma_value
    print("b_limit con inf+: ", b_limit)
elif b_limit == '-inf':
    b_limit = mu_value - 6*sigma_value
    print("b_limit con inf-: ", b_limit)
else:
    b_limit = b_limit    
    print("b_limit con numero: ", b_limit)


# Función para calcular la densidad de probabilidad gaussiana
def gaussian_density(x, mu, sigma):
    return norm.pdf(x, mu, sigma)

# Calcular y mostrar la integral en el rango especificado
integral_value = quad(gaussian_density, a_limit, b_limit, args=(mu_value, sigma_value))[0]
print("Valor de la integral es: ", integral_value)


# graficamos la función de densidad de probabilidad
x = np.linspace(a_limit, b_limit, 100)
y = gaussian_density(x, mu_value, sigma_value)
plt.plot(x,y)
plt.title('Distribución Gaussiana')
plt.xlabel('x')
plt.ylabel('f(x)')
plt.show()

