#!/bin/bash

# Verificar si se pasó un puerto como argumento
if [ -z "$1" ]; then
  echo "Error: Debes especificar un puerto."
  exit 1
fi

# Asignar el puerto pasado como argumento
PORT=$1

# Verificar si el puerto está en uso utilizando ss
if ss -tuln | grep ":$PORT " > /dev/null; then
  echo "El puerto $PORT está en uso."
else
  echo "El puerto $PORT no está en uso."
fi
