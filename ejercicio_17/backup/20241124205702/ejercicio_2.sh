#!/bin/bash

# Verifica si se pasó un correo electrónico como argumento
if [ -z "$1" ]; then
    echo "Error: No se proporcionó un correo electrónico."
    echo "Uso: $0 <correo@dominio.com>"
    exit 1
fi

# El correo electrónico se pasa como el primer argumento
EMAIL="$1"

# Umbral de alerta en porcentaje
THRESHOLD=80

# Función para enviar alerta
send_alert() {
    local usage=$1
    echo -e "Subject: Alerta de Uso de CPU\n\nEl uso de CPU es del $usage%, lo cual supera el umbral de $THRESHOLD%." | msmtp "$EMAIL"
}

# Monitorear el uso de la CPU cada 5 segundos
while true; do
    # Obtiene el uso de la CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/., *\([0-9.]\)%* id.*/\1/" | awk '{print 100 - $1}')
    
    # Si el uso de la CPU supera el umbral, envía una alerta
    if (( $(echo "$cpu_usage > $THRESHOLD" | bc -l) )); then
        send_alert $cpu_usage
    fi

    # Espera 5 segundos antes de volver a comprobar
    sleep 5
done
