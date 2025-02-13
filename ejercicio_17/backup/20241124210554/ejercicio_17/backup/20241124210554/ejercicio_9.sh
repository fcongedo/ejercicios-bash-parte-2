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
THRESHOLD=34

# Función para enviar alerta
send_alert() {
    local usage=$1
    echo -e "Subject: Alerta de Uso de Disco\n\nEl uso de la partición es del $usage%, lo cual supera el umbral de $THRESHOLD%." | msmtp "$EMAIL"
}

# Monitorear el uso de las particiones
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | while read line; do
    # Extraer el uso de disco y la partición
    usage=$(echo $line | awk '{ print $5 }' | sed 's/%//g')  # Eliminar el símbolo de porcentaje
    partition=$(echo $line | awk '{ print $1 }')

    # Comprobar si el valor de 'usage' es un número
    if ! [[ "$usage" =~ ^[0-9]+$ ]]; then
        continue  # Si 'usage' no es un número, pasar al siguiente
    fi

    # Si el uso de la partición supera el umbral, envía una alerta
    if [ "$usage" -gt "$THRESHOLD" ]; then
        send_alert "$usage"
    fi
done
