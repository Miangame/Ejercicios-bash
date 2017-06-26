#!/bin/bash

reset

echo -e "====\nListado de archivos ocultos del directorio $HOME"
# con ls -a [fichero] nos muestra todos lo archivos incluyendo los ocultos 
# aqeullo que empiezan por (.), para que solo nos muestre los ocultos
#usamos tambien egrep '^\.' para indicar que solo sean aquellos con un punto al inicio
# el \. es para que trate al punto como caracter punto
ls -a $HOME | egrep '^\.' | while read fichero
	#Una vez que solo mostramos los archivos ocultos con el bucle while y con el read los 
	#introduciomos uno por uno dentro de la varaible fichero para que asi podamos contar sus letras y haer lo que tengamos que hacer 
	do
		
		numeroletras=$(echo "$fichero"|wc -c)
		echo "$numeroletras$fichero"
		# al usar wc -c se nos quedan por ejemplo de esta forma 55 letras,  28 fichero, es decir el numero de letras delante de la palabra
		# por lo tanto ya podemos ordenar la salida del bucle pero luego hay que quitar ese numero.
	done | sort -n -k 1 | sed 's/[0-9]*\(..*\)/\1/'
	# con sort -n -k 1: con -n hacemos que se ordenen por numero de menor a mayor y con -k 1 que se fijen en el numero que hay 
	# en la primera columna, porque ya dijimos que tenidría este aspecto numero fichero
	# con el sed lo que hacemos es elimnar la primera clumna es decir el numero uqe indicaba el numero de caracteres	
	
	if [ -e "$1" ]
	then
		echo -e "====\nEl fichero a procesar es: $1"
		fich="$1".sinLineasVacias
		if [ -e $fich ]
		then 
			rm $fich
		fi
		
		cat "$1" | grep -e '[=[:alnum:]]' >> "$fich"
		echo "El fichero sin líneas vacías se ha guardado en: $fich"
	else
		echo "No existe el fichero!"
	fi

	echo -e "====\nListado de los procesos ejecutados por el usuario $USER"
	#para mostras los procesos que mi usaro esta ejecutando usamos
	#ps aux lista todos los proceosos con su respectiva informacio por pantalla.
	
	ps aux |sort -nr -k 2 | egrep $USER | sed -n -e 's/[^ ]\{1,\}[ ]\{1,\}\([^ ]\{1,\}\)[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}\([^ ]\{1,\}\)[ ]\{1,\}[^ ]\{1,\}[ ]\{1,\}\([^ ]\{1,\}\)/PID:"\1"  Ejecutable:"\3"  Hora de Inicio:"\2"/p'
	
	#explicacion del código:
		#ps aux: mostramos por pantalla todos los procesos con su respectiva informacion
		# | | | son tuberias y sirve para concadenar la salida de un comando a la entrada de otro es imprescindible para esta práctica.
		# sort -nr -k 2: es un comando para ordenar. El -k 2, escoge la 2 columna para ordenar que en este caso es el PID por la
		# tanto son numeros. Con el -nr ordenados por orden numero inverso es decir de mayor a menor. 
		#en este caso ordenamos los PID que es lo señalado por -k 2.
		# egrep $USER seleccionamos aquellas lineas la cual este nuestro usuario. Nos lo pide así el ejercicio.
		#En este caso no usamos '' para la expresion regular de grep ya que no es una expresion si ponemos las ''
		#lo trata como la cadena $USER asi que no tendría efecto poner la s ''.
		#sed -n -e  : con el -n indicamos que vamos a imprimir lo del sed por pantalla.
		# sed 's/cadena/reemplazo cadena/', la s despues del sed y seguida de /// indica reemplazo
		# s/[^ ]\{1,\} : decimos que no hay ninguno a avarios no espacios seguidos  es decir que no hay hay espacioss.
		# s/[ ]\{1,\} : indicamos que hay de uno a varios espacios seguidos
		# s/\([^ ]\{1,\}\) : es como el anterior pero en este caso almacenamos la infoamcion porque no es útil y asi la poemos
		# usar en el \n.
		#sed s//\1   \2   \3 : lo que hacemos es lo almacenado en los parentesis lo usamo ahora.por cada parentesis lo almacenado se le pone un numero.
		
		
		#caso curioso: sed -n -e '2,$' : 2 indica que empieza en la linea 2, y el $ infdica que llega hasta la ultima linea. 
		
	
		
		
