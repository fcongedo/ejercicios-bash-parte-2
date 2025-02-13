#!/bin/bash

# Verificar si se proporcionó un directorio como argumento
if [ -z "$1" ]; then
    echo "Error: No se proporcionó un directorio."
    echo "Uso: $0 <ruta_del_directorio>"
    exit 1
fi

DIRECTORIO="$1"

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio '$DIRECTORIO' no existe."
    exit 1
fi

# Buscar y reemplazar "error" por "warning" en cada archivo del directorio
for archivo in "$DIRECTORIO"/*; do
    if [ -f "$archivo" ]; then
        sed -i 's/error/warning/g' "$archivo"
        echo "Procesado: $archivo"
    fi
done

echo "Reemplazo completado."
