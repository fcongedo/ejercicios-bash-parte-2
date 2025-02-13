#!/bin/bash

# Verificar si se pasó el directorio como parámetro
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

# Asignar el parámetro a una variable
DIRECTORIO="$1"

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "El directorio especificado no existe: $DIRECTORIO"
    exit 1
fi

# Buscar archivos de más de 30 días
ARCHIVOS_ANTIGUOS=$(find "$DIRECTORIO" -type f -mtime +30)

# Verificar si se encontraron archivos antiguos
if [ -z "$ARCHIVOS_ANTIGUOS" ]; then
    echo "No se encontraron archivos de más de 30 días en $DIRECTORIO."
else
    # Borrar los archivos de más de 30 días de antigüedad
    find "$DIRECTORIO" -type f -mtime +30 -exec rm -f {} \;
    echo "Archivos de más de 30 días han sido eliminados de $DIRECTORIO."
fi
