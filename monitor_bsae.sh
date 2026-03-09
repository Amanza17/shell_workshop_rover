#!/bin/bash
# DASHBOARD DE CONTROL - ROVER 2026
NC='\033[0m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; GREEN='\033[0;32m'
LOG_FILE="rover_system.log"

# UMBRALES DE SEGURIDAD (Thresholds)
MAX_TEMP=0
MIN_BATT=0
MAX_RPM=0

MODE="all"
AVERAGE="false"

#Para opcional flags

#for arg in "$@"; do
#    case "$arg" in
#        -t) MODE="temp" ;;
#
#   esac
#done


clear
echo -e "${CYAN}>>> MONITOR INICIADO. ESPERANDO TELEMETRÍA... <<<\${NC}"
touch $LOG_FILE

# Leer el log en tiempo real línea a línea
tail -f $LOG_FILE | while read -r line; do
    clear
    echo -e "${CYAN}==================================================${NC}"
    echo -e "         DASHBOARD DE CONTROL - ROVER 2026        "
    echo -e "${CYAN}==================================================${NC}"
    
    # --- TAREA ALUMNOS: Extraer datos con grep y awk ---


    echo -e "${CYAN}--------------------------------------------------${NC}"


    echo -e "  TEMP:    ${YELLOW}${MAX_TEMP:-'--'}°C${NC}" #sustituit por los valores correctos
    echo -e "  ENERGÍA: ${GREEN}${MAX_RPM:-'--'}%${NC}" #sustituit por los valores correctos
    echo -e "  RPM:     ${CYAN}${MAX_BAT:-'--'} RPM${NC}" #sustituit por los valores correctos

    echo -e "${CYAN}--------------------------------------------------${NC}"
    echo -e "  ULTIMA LÍNEA RECIBIDA: $line"
    echo -e "${CYAN}--------------------------------------------------${NC}"

    
    
done
