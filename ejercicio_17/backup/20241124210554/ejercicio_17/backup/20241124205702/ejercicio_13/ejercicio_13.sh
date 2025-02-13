#!/bin/bash

# Archivo de log de Apache (puede variar según tu configuración)
LOG_FILE="/var/log/apache2/access.log"

# Verificar si el archivo de log existe
if [ ! -f "$LOG_FILE" ]; then
  echo "Error: El archivo de log $LOG_FILE no existe."
  exit 1
fi

# Contar las IPs que han accedido al servidor
echo "Contando las visitas por IP..."

# Procesar el log y contar cuántas veces cada IP ha accedido
# 1. Obtener la primera columna del log (la IP)
# 2. Contar cuántas veces aparece cada IP
# 3. Ordenar los resultados por frecuencia (de mayor a menor)
cat "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -nr > ips_contadas.log

# Mostrar el resultado
echo "El conteo de accesos por IP se guardó en 'ips_contadas.log'."
cat ips_contadas.log
