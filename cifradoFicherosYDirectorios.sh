#!/bin/bash

for RutaCompleta in $1	#Busco los nombres de los archivos y directorios en la ruta pasada por el primer parametro
do
	NombreArchivo="${RutaCompleta##*/}"	#Con esto guardo el nombre con la extension

	NombreSolo="${NombreArchivo%.[^.]*}"	#Con esto obtengo el nombre sin extension
done


if [ -f "$1" ]	#Entro si el parametro pasado es un fichero
then
	echo "Procesando un fichero..."
	fich="$1".gpg	#Le añado al fichero la extensión .gpg
	gpg --output "$fich" --symmetric "$1"	#Cifro el fichero
	rm "$1"		#Borro el fichero original para que solo se quede el resultante
	echo "Fichero cifrado resultante: $fich"
elif [ -d "$1" ]	#Entro si el parametro pasado es un directorio
then
	echo "Procesando un directorio..."

	dir="$NombreSolo".tar.gz	#Le añado la extensión .tar.gz al nombre del directorio
	tar zcvf "$dir" "$1" 1> /dev/null	#Comprimo el directorio
	
	dir2="$dir".gpg		#Le añado la extension .gpg al archivo anterior
	gpg --output "$dir2" --symmetric "$dir"		#Cifro el archivo copmprimido
	rm $dir 	#Borro el archivo original para que solo se quede el resultante
	echo "Fichero cifrado resultante: $dir2"
else	#Entro si no es un fichero ni un directorio
	echo "Por favor introduzca un fichero o directorio!!"
fi