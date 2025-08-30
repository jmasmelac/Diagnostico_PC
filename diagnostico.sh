#!/bin/bash

echo "============================="
echo " INFORMACIÓN DEL SISTEMA"
echo "============================="

# EQUIPO
echo -e "\n>> EQUIPO:"
echo -n "Fabricante: "
sudo dmidecode -s system-manufacturer 2>/dev/null
echo -n "Modelo: "
sudo dmidecode -s system-product-name 2>/dev/null
echo -n "Número de serie: "
sudo dmidecode -s system-serial-number 2>/dev/null

# CPU
echo -e "\n>> CPU:"
cpu_model=$(grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2 | xargs)
echo "Modelo: $cpu_model"
echo "Núcleos disponibles: $(nproc)"

# RAM
echo -e "\n>> MEMORIA RAM:"
free -h --si | awk 'NR==1 || /Mem:/ {print $0}'
echo -n "Total detectado: "
grep MemTotal /proc/meminfo | awk '{printf "%.2f GiB\n", $2/1024/1024}'
echo -n "Slots en uso: "
sudo dmidecode -t memory | grep -c 'Size: [1-9]' 2>/dev/null
echo -n "Slots totales: "
sudo dmidecode -t memory | grep -c 'Locator:' 2>/dev/null

# DISCO
echo -e "\n>> DISCO:"
lsblk -dno NAME,SIZE,MODEL | grep -v loop

# SMART
echo -e "\nSMART (si está disponible):"
if ! command -v smartctl &> /dev/null; then
  echo "SMART no disponible. Instala con: sudo apt install smartmontools"
else
  for d in $(lsblk -dno NAME); do
    echo ">>> /dev/$d"
    sudo smartctl -H /dev/$d | grep "SMART overall-health"
  done
fi

# RED
echo -e "\n>> RED:"
ip -brief address | grep -v lo

# GPU
echo -e "\n>> GPU:"
lspci | grep -i 'vga\|3d'

# BATERÍA
echo -e "\n>> BATERÍA:"
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|energy-full-design|energy-full|charge-cycles|percentage|capacity"

# FECHA
echo -e "\n>> FECHA Y HORA:"
date

echo -e "\nListo. Diagnóstico completo."
