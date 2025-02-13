#!/bin/bash

# Verificar si se proporcionó el archivo con los nombres de los usuarios y contraseñas
if [ $# -ne 1 ]; then
  echo "Error: Debes proporcionar el archivo con los nombres de usuario y contraseñas."
  exit 1
fi

# Archivo que contiene los nombres de usuario y contraseñas
USER_LIST="$1"

# Verificar si el archivo existe
if [ ! -f "$USER_LIST" ]; then
  echo "Error: El archivo $USER_LIST no existe."
  exit 1
fi

# Leer cada línea del archivo
while IFS=' ' read -r username password; do
  # Verificar si el usuario ya existe
  if id "$username" &>/dev/null; then
    echo "El usuario $username ya existe, saltando..."
  else
    # Crear el usuario sin asignar un directorio home
    useradd -m "$username"
    
    # Verificar si la creación fue exitosa
    if [ $? -eq 0 ]; then
      echo "Usuario $username creado exitosamente."
      
      # Asignar la contraseña directamente al usuario
      echo "$username:$password" | chpasswd
      
      # Verificar si la contraseña fue asignada correctamente
      if [ $? -eq 0 ]; then
        echo "Contraseña asignada exitosamente a $username."
      else
        echo "Error al asignar la contraseña a $username."
      fi
      
      # Forzar el cambio de contraseña en el primer inicio de sesión
      chage -d 0 "$username"
      echo "El usuario $username deberá cambiar su contraseña al primer inicio de sesión."
    else
      echo "Error al crear el usuario $username."
    fi
  fi
done < "$USER_LIST"

echo "Proceso de creación de usuarios finalizado."
