# obtener el valor de una letra segun sea el caso

# usa la formula c^d mod n
# definimos mensaje

mensaje = [14, 12, 15, 3, 20, 1, 23, 15, 16, 1, 16]


# definimos las claves
n = 33
e = 7
d = 3

# obtenemos el mensaje
mensaje = [chr((letra**d)%n+96) for letra in mensaje]

# imprimimos el mensaje
print("".join(mensaje))