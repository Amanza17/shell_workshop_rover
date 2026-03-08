#!/bin/bash
# DASHBOARD DE CONTROL - ROVER 2026
NC='\033[0m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; GREEN='\033[0;32m'
LOG_FILE="rover_system.log"
touch $LOG_FILE
# UMBRALES DE SEGURIDAD (Thresholds)
MAX_TEMP=50
MIN_BATT=15
MAX_RPM=3000
clear
echo -e "${CYAN}>>> MONITOR INICIADO. ESPERANDO TELEMETRÍA... <<<\${NC}"

# Leer el log en tiempo real línea a línea
tail -f $LOG_FILE | while read -r line; do
    clear
    echo -e "${CYAN}==================================================${NC}"
    echo -e "         DASHBOARD DE CONTROL - ROVER 2026        "
    echo -e "${CYAN}==================================================${NC}"
    
    # --- TAREA ALUMNOS: Extraer datos con grep y awk ---
    # --- TAREA ALUMNOS: Extraer datos con grep y awk ---
    
    # Extraemos la temperatura (Última línea que contenga [TEMP])
    TEMP=$(grep "\[TEMP\]" $LOG_FILE | tail -n 1 | awk '{print $NF}')
    
    # Extraemos las RPM (Última línea que contenga [MOTORES])
    RPM=$(grep "\[MOTORES\]" $LOG_FILE | tail -n 1 | awk '{print $NF}')
    
    # Extraemos la Batería (Última línea que contenga [BATT])
    BATT=$(grep "\[BATT\]" $LOG_FILE | tail -n 1 | awk '{print $NF}')

    # --- RENDERIZADO DE DATOS ---
    echo -e "  TERMÓMETRO: ${YELLOW}${TEMP:-'--'}°C${NC}"
    echo -e "  MOTORES:     ${CYAN}${RPM:-'--'} RPM${NC}"
    echo -e "  ENERGÍA:    ${GREEN}${BATT:-'--'}%${NC}"
    # --- TAREA ALUMNOS: Lógica de Watchdog para 'CRITICAL' ---
    
# --- TAREA ALUMNOS: Lógica de Watchdog por Umbrales ---

    # 1. Validar Temperatura
    if [ "${TEMP:-0}" -gt "$MAX_TEMP" ]; then
        echo -e "${RED}[!] ALERTA: Temperatura crítica: ${TEMP}°C (Límite: $MAX_TEMP)${NC}"
        echo "$(date +%T) [WATCHDOG] EMERGENCIA: Sobrecalentamiento detectado" >> $LOG_FILE
            # Detener el generador de datos si hay peligro
        pkill -f data_generator.sh
        echo -e "${RED}SISTEMA DETENIDO POR SEGURIDAD.${NC}"
        exit

    fi

    # 2. Validar Batería
    if [ "${BATT:-100}" -lt "$MIN_BATT" ]; then
        echo -e "${RED}[!] ALERTA: Batería baja: ${BATT}% (Límite: $MIN_BATT)${NC}"
        echo "$(date +%T) [WATCHDOG] AVISO: Nivel de energía crítico" >> $LOG_FILE
            # Detener el generador de datos si hay peligro
        pkill -f data_generator.sh
        echo -e "${RED}SISTEMA DETENIDO POR SEGURIDAD.${NC}"
        exit

    fi

    # 3. Validar Motores
    if [ "${RPM:-0}" -gt "$MAX_RPM" ]; then
        echo -e "${RED}[!] ALERTA: RPM excesivas: ${RPM} (Límite: $MAX_RPM)${NC}"
        echo "$(date +%T) [WATCHDOG] EMERGENCIA: Exceso de velocidad en motores" >> $LOG_FILE
            # Detener el generador de datos si hay peligro
        pkill -f data_generator.sh
        echo -e "${RED}SISTEMA DETENIDO POR SEGURIDAD.${NC}"
        exit
    fi


    echo -e "  ULTIMA LÍNEA RECIBIDA: $line"
    echo -e "${CYAN}--------------------------------------------------${NC}"
    
    # --- TAREA ALUMNOS: Lógica de Watchdog para 'CRITICAL' ---
done
