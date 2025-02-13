#!/bin/bash

# Verificar si se pasaron los parámetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <directorio_origen> <directorio_destino>"
    exit 1
fi

# Asignar los parámetros a variables
ORIGEN="$1"
DESTINO="$2"
LOGFILE="$DESTINO/backup.log"  # Archivo de log en el directorio de destino

# Verificar si el directorio de origen existe
if [ ! -d "$ORIGEN" ]; then
    echo "El directorio de origen no existe: $ORIGEN"
    exit 1
fi

# Crear el directorio de destino si no existe
mkdir -p "$DESTINO"

# Realizar el backup incremental con rsync
rsync -av --delete --link-dest="$DESTINO/ultimo_backup" "$ORIGEN/" "$DESTINO/$(date +%Y%m%d%H%M%S)"

# Crear o actualizar el archivo de log
echo "$(date +'%Y-%m-%d %H:%M:%S') - Backup incremental realizado desde $ORIGEN hacia $DESTINO" >> "$LOGFILE"

# Actualizar el enlace simbólico 'ultimo_backup'
rm -f "$DESTINO/ultimo_backup"
ln -s "$DESTINO/$(date +%Y%m%d%H%M%S)" "$DESTINO/ultimo_backup"

echo "Backup incremental completado."
