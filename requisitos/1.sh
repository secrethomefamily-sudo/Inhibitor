#!bin/bash

source installer.sh


clear
logo1
sleep 1
    echo -e "$white"
echo "[1] Estado Tarjeta de Red"
echo
echo
echo "##############################################"
echo "[##] Datos técnicos: "
echo "##############################################"
echo
sudo iwconfig 
echo
echo "##############################################"
echo "[##] Interfaz, Drivers, Chipset: "
echo "##############################################"
sudo airmon-ng
echo "##############################################"
echo "[##] Interzaces + MAC: "
echo "##############################################"
echo
sudo ifconfig -a | awk '/^[a-z]/ { iface=$1; } /inet addr:/ { next; } /^[[:space:]]*ether/ { print iface,$2; }'
echo
echo "##############################################"
echo "[##] Modos compatibles con la Tarjeta de Red: "
echo "##############################################"
echo
sudo iw list | awk '/Supported interface modes/,/Band/{if(NR>1)print}' | head -n -1
echo
echo "##############################################"
echo "[##] Modo Tajeta de Red (Monitor/Manager): "
echo "##############################################"
echo
sudo iwconfig | grep -oP '^\S+' | xargs -n1 sh -c 'echo -n $0" Mode:"; iwconfig $0 | awk -F "\"" "/Mode/ {print $2}"'
echo
echo "##############################################"
echo "[##] Tasa de Transferencia de Datos: "
echo "##############################################"
echo
sudo iw list | grep -oP "VHT TX highest supported:\s*\K\d+" | awk '{print "Tasa de transferencia: " $1 " Mbps"}'
echo
echo
echo "#####################"
echo "[1] Volver al Menu"
echo "[2] Volver a ejecutar"
echo "[3] Salir"
echo "#####################"
echo
read -p "Elige una opcion: " opc2
	case $opc2 in
			1 )	bash inhibitor.sh
				;;
			2 )	bash requisitos/1.sh
				;;
			3 )	exit
				;;
			* )	echo
				echo "$RRPLY No es una opcion valida"
	esac
