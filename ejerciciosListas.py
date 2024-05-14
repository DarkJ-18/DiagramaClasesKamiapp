#crear una lista
lista= [1,2,3,4,5]
print(lista)
#imprimir un numero de la lista
print(lista[3])
#modificar el numero 1
lista[1]=10
print(lista)
#Agrgar un nuevo campo a la lista
lista.append(6)
print(lista)
#eliminar un elemento por valor
buscar=10
lista.remove(buscar)
print(lista)
#eliminar un elemento por indice
i=0
del lista[0]
print(lista)
#longitud de la lista
print(len(lista))
#extender la lista
lista.extend([7,8,9])
print(lista)
#insertar un elemento
lista.insert(0,0)
print(lista)
#limpiar la lista
lista.clear()
print(lista)
#revertir la lista
