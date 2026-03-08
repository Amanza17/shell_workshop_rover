#!/bin/bash

<<COMMENT
# En caso de hacerlo como funciones:
generar_temp() {
    TEMP=$(( (RANDOM % 41) + 20 ))
    echo "[$(date +%T)] [TEMP] $TEMP" >> rover_system.log
}
COMMENT

while true; do
    # Rango de Batería: 5 a 100%
    BATT=$(( (RANDOM % 96) + 5 ))
    
    # Formato de salida
    echo "[$(date +%T)] [BATT] $BATT" >> rover_system.log
    sleep 1

    # Generamos el valor (SIN espacios en el = y el $(()) )
    TEMP=$(( ( RANDOM % 41 ) + 20 ))
    
    # Escribimos en el log (formato limpio)
    echo "[$(date +%T)] [TEMP] $TEMP" >> rover_system.log
    
    sleep 1

    # Rango de RPM: de 1000 a 3500
    # (RANDOM % 2501) genera 0-2500, + 1000 = 1000-3500
    RPM=$(( (RANDOM % 2501) + 1000 ))
    
    # Formato de salida
    echo "[$(date +%T)] [MOTORES] $RPM" >> rover_system.log
    
    # Frecuencia: 1Hz
    sleep 1
done
