#!/bin/bash

# Verificar si se proporcionaron los directorios de origen y destino
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Debes proporcionar tanto el directorio de origen como el de destino."
    echo "Uso: $0 <directorio_origen> <directorio_destino>"
    exit 1
fi

# Asignar las variables para los directorios
directorio_origen="$1"
directorio_destino="$2"

# Verificar si el directorio de origen existe
if [ ! -d "$directorio_origen" ]; then
    echo "Error: El directorio de origen '$directorio_origen' no existe."
    exit 1
fi

# Verificar si el directorio de destino existe, si no, crearlo
if [ ! -d "$directorio_destino" ]; then
    echo "El directorio de destino '$directorio_destino' no existe. Creando..."
    mkdir -p "$directorio_destino"
    if [ $? -eq 0 ]; then
        echo "Directorio '$directorio_destino' creado exitosamente."
    else
        echo "Error: No se pudo crear el directorio '$directorio_destino'."
        exit 1
    fi
fi

# Obtener la fecha actual en formato AAAA-MM-DD_HHMM
fecha_actual=$(date +"%Y-%m-%d_%H%M")

# Crear el nombre del archivo comprimido con la fecha actual
nombre_archivo_backup="backup_$fecha_actual.tar.gz"

# Comprimir el directorio de origen en un archivo tar.gz en el directorio de destino
tar -czf "$directorio_destino/$nombre_archivo_backup" -C "$directorio_origen" .

# Verificar si la copia de seguridad se realizó con éxito
if [ $? -eq 0 ]; then
    echo "La copia de seguridad se completó exitosamente en: $directorio_destino/$nombre_archivo_backup"
else
    echo "Error: La copia de seguridad falló."
    exit 1
fi
