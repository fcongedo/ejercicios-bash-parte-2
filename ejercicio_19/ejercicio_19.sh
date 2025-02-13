#!/bin/bash

# Verificar si se pasaron los parámetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <directorio_logs> <dias_antiguedad>"
    exit 1
fi

# Asignar los parámetros a variables
DIRECTORIO_LOGS="$1"
DIAS_ANTIGUEDAD="$2"
DIRECTORIO_DESTINO="$PWD/backup_logs"  # Carpeta de respaldo en el directorio actual
FECHA=$(date +%Y%m%d%H%M%S)  # Fecha actual para nombrar los archivos comprimidos

# Verificar si el directorio de logs existe
if [ ! -d "$DIRECTORIO_LOGS" ]; then
    echo "El directorio de logs no existe: $DIRECTORIO_LOGS"
    exit 1
fi

# Verificar si el directorio de destino existe, si no, lo crea
if [ ! -d "$DIRECTORIO_DESTINO" ]; then
    echo "El directorio de respaldo no existe. Creando: $DIRECTORIO_DESTINO"
    mkdir -p "$DIRECTORIO_DESTINO"
    if [ $? -eq 0 ]; then
        echo "Directorio de respaldo creado correctamente."
    else
        echo "Error al crear el directorio de respaldo."
        exit 1
    fi
fi

# Mover y comprimir los archivos de log más viejos (modificados hace más de $DIAS_ANTIGUEDAD días)
find "$DIRECTORIO_LOGS" -type f -name "*.log" -mtime +$DIAS_ANTIGUEDAD | while read archivo; do
    # Crear el nombre del archivo comprimido con la fecha y el nombre original
    NOMBRE_ARCHIVO_COMPRIMIDO="$DIRECTORIO_DESTINO/$(basename "$archivo" .log)_$FECHA.gz"
    
    # Comprimir el archivo y moverlo al directorio de respaldo
    gzip -c "$archivo" > "$NOMBRE_ARCHIVO_COMPRIMIDO"
    
    # Eliminar el archivo original
    rm "$archivo"
    
    echo "Archivo comprimido y movido: $archivo -> $NOMBRE_ARCHIVO_COMPRIMIDO"
done

# Mostrar mensaje de éxito
echo "Los archivos de log antiguos han sido comprimidos y movidos al directorio de respaldo."
