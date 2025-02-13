#!/bin/bash

# Verificar si se pasaron los parámetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <directorio_1> <directorio_2>"
    exit 1
fi

# Asignar los parámetros a variables
DIR1="$1"
DIR2="$2"

# Verificar si los directorios existen
if [ ! -d "$DIR1" ]; then
    echo "El directorio no existe: $DIR1"
    exit 1
fi

if [ ! -d "$DIR2" ]; then
    echo "El directorio no existe: $DIR2"
    exit 1
fi

# Mostrar archivos en DIR1 que no están en DIR2
echo "Archivos en $DIR1 que no están en $DIR2:"
comm -23 <(ls -1 "$DIR1" | sort) <(ls -1 "$DIR2" | sort)

# Mostrar archivos en DIR2 que no están en DIR1
echo "Archivos en $DIR2 que no están en $DIR1:"
comm -13 <(ls -1 "$DIR1" | sort) <(ls -1 "$DIR2" | sort)
