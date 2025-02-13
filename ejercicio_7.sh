#!/bin/bash

# Verificar si se proporcionó un nombre de servicio
if [ -z "$1" ]; then
    echo "Error: No se proporcionó un servicio."
    echo "Uso: $0 <nombre_del_servicio>"
    exit 1
fi

# Asignar el parámetro a la variable SERVICIO
SERVICIO="$1"

# Verificar si el servicio está activo
if systemctl is-active --quiet $SERVICIO; then
    echo "$SERVICIO está activo."
else
    echo "$SERVICIO no está activo. Reiniciando..."
    sudo systemctl restart $SERVICIO
    if systemctl is-active --quiet $SERVICIO; then
        echo "$SERVICIO ha sido reiniciado exitosamente."
    else
        echo "No se pudo reiniciar $SERVICIO."
    fi
fi
