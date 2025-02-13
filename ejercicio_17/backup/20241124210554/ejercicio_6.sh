#!/bin/bash

# Directorio donde buscar los archivos grandes
directorio="/var/log"

# Buscar archivos de más de 100MB
find "$directorio" -type f -size +5M | while read archivo; do
    # Verificar si el archivo no está comprimido ya
    if [[ "$archivo" != *.gz ]]; then
        # Comprimir el archivo
        gzip "$archivo"
        
        # Verificar si la compresión fue exitosa
        if [ $? -eq 0 ]; then
            echo "Archivo comprimido: $archivo"
        else
            echo "Error al comprimir el archivo: $archivo"
        fi
    fi
done
