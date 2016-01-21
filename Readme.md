Se necesita implementar un algoritmo para que, dado un conjunto de pares de valores, que representan el peso y  la altura de un grupo de personas, se obtenga un listado con el mayor número de personas posible en el que se cumpla que cada individuo tiene mayor peso y altura que el inmediatamente anterior en el listado.

Tres alternativas para ordenar un grupo de personas:
Ordenados de menor a mayor eficiencia.

	1 - Algoritmo puramente lógico de ordenamiento.
	    La idea es ordenar la lista por una sola propiedad (altura o peso) e ir iterando sobre ella. Tomando una subselección de personas que compartan el valor de dicha propiedad. Y de ellos, seleccionar al que tenga la otra propiedad (altura o peso) con el valor más bajo.

	2 - Algoritmo a través del uso de la estadística.
	    Usamos los datos de altura y peso para crear una variable que determine el grado de proporcionalidad entre ellas. Eso permite evitar a las personas con mayor grado de desproporción y mejorar el rendimiento en el espacio de la lista.

	3 - Algoritmo genial, directo y simple inspirado a través del estudio de los árboles de decisiones.
	    Ordenamos la lista en función del número de otros posibles valores disponibles para ordenar en cada elemento. Si tomo a una persona cualquiera cuantas otras personas son susceptibles de combinarse con ella.

	

