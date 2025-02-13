#!/bin/bash

# Verificar si se pasó un archivo de hosts
if [ -z "$1" ]; then
  echo "Error: Debes especificar un archivo con la lista de hosts."
  exit 1
fi

# Archivo con la lista de hosts (uno por línea)
HOSTS_FILE="$1"

# Archivo de log donde se guardarán los resultados
LOG_FILE="ping_results.log"

# Agregar una cabecera con la fecha y hora de la ejecución
echo "Resultados del ping a múltiples hosts - $(date)" >> "$LOG_FILE"
echo "--------------------------------------------------------" >> "$LOG_FILE"

# Leer el archivo de hosts línea por línea
while IFS= read -r HOST; do
  # Verificar que la línea no esté vacía
  if [ -n "$HOST" ]; then
    # Realizar el ping a cada host (3 intentos)
    echo "Haciendo ping a $HOST..." >> "$LOG_FILE"
    ping -c 3 "$HOST" >> "$LOG_FILE" 2>&1
    echo "--------------------------------------------------------" >> "$LOG_FILE"
  fi
done < "$HOSTS_FILE"

# Mensaje final
echo "El resultado del ping se ha guardado en el archivo $LOG_FILE."
