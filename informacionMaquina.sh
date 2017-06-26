#!/bin/bash

reset

#Guardamos en variables los archivos que vamos a usar
cpu=/proc/cpuinfo
mounts=/proc/mounts
parts=/proc/partitions

cat "$cpu" | sed -r -n -e 's/model name.*[:](.*)/Modelo de procesador: \1/p' >> tmp.txt
cat tmp.txt | sed -n '1p'
rm tmp.txt

cat "$cpu" | sed -r -n -e 's/cpu MHz.*[:](.*)/Megahercios: \1/p' >> tmp.txt
cat tmp.txt | sed -n '1p'
rm tmp.txt

cat "$cpu" | sed -r -n -e 's/^cpuid.*level.*:(.*)/Número de hilos máximo de ejecución: \1/p' >> tmp.txt
cat tmp.txt | sed -n '1p'
rm tmp.txt

echo -e "====\nPuntos de montaje:"
cat "$mounts" | sed -r -n -e 's/(.*)\ \/(.*)\ (.*)\ [rw].*/->Punto de montaje: \/\2, Dispositivo: \1, Tipo de dispositivo: \3/p' >> tmp.txt
cat tmp.txt | sort -k 2
rm tmp.txt

echo -e "====\nParticiones y número de bloques:"
cat "$parts" | sed -r -n -e 's/.*\ +.*\ +(.*)\ +(.*)/Particion: \2, Número de bloques: \1/p' >> tmp.txt
cat tmp.txt | sed -e '1d' | sort -k4n
rm tmp.txt
