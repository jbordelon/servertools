#!/bin/bash
# JRB 15ago19 5nov20
# Para ver la temperatura del CPU
# Ctr C para salir
trap ctrl_c INT

function ctrl_c() {
  echo -en "\r$T ºC     "
  # tput init
  echo $'\033[0m'
  exit 0
}

function mide(){
  T=$(cat /sys/class/thermal/thermal_zone0/temp)
  T=${T:0:2}.${T:2:2}
  if [[ ${T%.*} < 50 ]] ; then
    # Verde
    echo -en "\e[1m\e[92m  $T ºC $1 \r"
  elif [[ ${T%.*} < 60 ]] ; then
    # Amarillo
    echo -en "\e[1m\e[93m  $T ºC $1 \r"
  else
    # Rojo
    echo -en "\e[1m\e[91m  $T ºC $1 \r"
  fi
  sleep 1
}

echo 'Temperatura en ºC (Ctr-C para salir)'
for (( ; ; )) do
  mide "|"
  mide "/"
  mide "-"
  mide "\\"
done
