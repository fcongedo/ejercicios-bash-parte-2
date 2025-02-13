#!/bin/bash

# Verificar si se proporcionó un directorio como argumento
if [ -z "$1" ]; then
    echo "Error: No se proporcionó un directorio para enlazar."
    echo "Uso: $0 <directorio_origen>"
    exit 1
fi

# Asignar la variable al directorio origen
directorio_origen="$1"

# Verificar si el directorio de origen existe
if [ ! -d "$directorio_origen" ]; then
    echo "Error: El directorio '$directorio_origen' no existe."
    exit 1
fi

# Crear el directorio 'deploy' si no existe
if [ ! -d "deploy" ]; then
    echo "Creando el directorio 'deploy'..."
    mkdir deploy
    if [ $? -eq 0 ]; then
        echo "Directorio 'deploy' creado exitosamente."
    else
        echo "Error al crear el directorio 'deploy'."
        exit 1
    fi
else
    echo "El directorio 'deploy' ya existe."
fi

# Enlazar simbólicamente los archivos del directorio origen al directorio 'deploy'
for archivo in "$directorio_origen"/*; do
    if [ -f "$archivo" ]; then
        ln -s "$archivo" "deploy/$(basename "$archivo")"
        echo "Enlazado: $archivo a deploy/$(basename "$archivo")"
    fi
done

echo "Enlaces simbólicos creados exitosamente."
