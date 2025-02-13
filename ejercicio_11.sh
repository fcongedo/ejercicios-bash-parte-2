#!/bin/bash

# Verificar que se pase al menos un directorio como parámetro
if [ "$#" -lt 1 ]; then
  echo "Error: Debes pasar al menos un directorio para hacer la copia de seguridad."
  exit 1
fi

# Directorio de destino donde se guardarán las copias
BACKUP_DIR="/mnt/backup"  # Puedes cambiar esto a donde quieras que se guarde el respaldo

# Archivo de log donde se guardarán los detalles del respaldo
LOG_FILE="/var/log/copia_seguridad.log"

# Agregar tarea cron para ejecutarse todos los días a las 2 AM
CRON_JOB="0 2 * * * /bin/bash /home/feco2/ejercicios-bash/ejercicio_11.sh $* >> /var/log/copia_seguridad_cron.log 2>&1"

# Agregar la tarea cron
echo "$CRON_JOB" | crontab -

# Agregar la fecha y hora de inicio al log
echo "Iniciando la copia de seguridad: $(date)" >> $LOG_FILE

# Crear el directorio de destino si no existe
if [ ! -d "$BACKUP_DIR" ]; then
  echo "El directorio de destino $BACKUP_DIR no existe. Creando..." >> $LOG_FILE
  mkdir -p "$BACKUP_DIR"
fi

# Iterar sobre cada directorio pasado como parámetro
for SOURCE_DIR in "$@"; do
  # Agregar la fecha y hora de inicio para cada directorio
  echo "Iniciando la copia de seguridad de $SOURCE_DIR: $(date)" >> $LOG_FILE

  # Comprobar si el directorio de origen existe
  if [ -d "$SOURCE_DIR" ]; then
    # Realizar la copia de seguridad usando rsync
    echo "Copiando $SOURCE_DIR a $BACKUP_DIR..." >> $LOG_FILE
    rsync -avh --progress "$SOURCE_DIR" "$BACKUP_DIR" >> $LOG_FILE 2>&1

    # Verificar si la copia fue exitosa
    if [ $? -eq 0 ]; then
      echo "Copia de $SOURCE_DIR completada exitosamente: $(date)" >> $LOG_FILE
    else
      echo "Error al copiar $SOURCE_DIR: $(date)" >> $LOG_FILE
    fi
  else
    echo "Error: El directorio $SOURCE_DIR no existe. No se puede realizar la copia." >> $LOG_FILE
  fi
done

# Agregar la fecha y hora de finalización al log
echo "Copia de seguridad completada: $(date)" >> $LOG_FILE
