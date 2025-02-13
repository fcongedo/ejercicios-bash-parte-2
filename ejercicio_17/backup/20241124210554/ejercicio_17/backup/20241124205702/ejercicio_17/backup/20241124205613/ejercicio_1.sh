#!/bin/bash

# Verificar si se pasó un directorio como parámetro
if [ -z "$1" ]; then
  echo "Uso: $0 <directorio>"
  exit 1
fi

# Directorio pasado como parámetro
DIRECTORIO="$1"

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
  echo "Error: El directorio '$DIRECTORIO' no existe."
  exit 1
fi

# Cambiar al directorio
cd "$DIRECTORIO" || exit

# Renombrar cada archivo .txt a .bak
for archivo in *.txt; do
  if [ -f "$archivo" ]; then
    mv "$archivo" "${archivo%.txt}.bak"
    echo "Renombrado: $archivo -> ${archivo%.txt}.bak"
  fi
done

echo "Todos los archivos .txt han sido renombrados a .bak en el directorio '$DIRECTORIO'"
