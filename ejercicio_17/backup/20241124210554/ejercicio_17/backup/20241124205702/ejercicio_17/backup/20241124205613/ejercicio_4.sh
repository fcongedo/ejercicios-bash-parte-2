#!/bin/bash

# Función para validar una dirección IPv4
validar_ip() {
    local ip=$1

    # Expresión regular para validar la dirección IPv4
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        # Verificar que cada octeto esté en el rango de 0 a 255
        IFS='.' read -r -a octetos <<< "$ip"
        for octeto in "${octetos[@]}"; do
            if ((octeto < 0 || octeto > 255)); then
                echo "No es una dirección IP válida: $ip"
                return 1
            fi
        done
        echo "La dirección IP '$ip' es válida."
        return 0
    else
        echo "No es una dirección IP válida: $ip"
        return 1
    fi
}

# Verificar si se proporcionó una IP como parámetro
if [ -z "$1" ]; then
    echo "Error: No se proporcionó una dirección IP."
    echo "Uso: $0 <dirección_ip>"
    exit 1
fi

# Llamar a la función de validación
validar_ip "$1"
