#!/bin/bash

# Verificar si se pasó un argumento (nombre de archivo)
if [ -z "$1" ]; then
  echo "Error: No se ha proporcionado un nombre de archivo."
  echo "Uso: $0 <nombre_archivo>"
  exit 1
fi

# Obtener el nombre del archivo pasado como argumento
FILE_NAME="$1"

# Buscar el archivo en todo el sistema (comienza desde la raíz)
echo "Buscando '$FILE_NAME' en todo el sistema..."

# El comando find buscará el archivo comenzando desde la raíz "/"
RESULTADO=$(find / -type f -name "$FILE_NAME" 2>/dev/null)

# Verificar si se encontró el archivo
if [ -n "$RESULTADO" ]; then
  echo "El archivo '$FILE_NAME' fue encontrado en las siguientes ubicaciones:"
  echo "$RESULTADO"
else
  echo "El archivo '$FILE_NAME' no fue encontrado en el sistema."
fi
