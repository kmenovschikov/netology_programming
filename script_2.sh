#!/bin/bash

echo "Vash IP=$(hostname -I)"

INTERFACE=$1
PREFIX=$(hostname -I | cut -d '.' -f 3- --complement)
SUB_OT=$(hostname -I | cut -d '.' -f 3- | cut -d '.' -f 2- --complement)
SUB_DO=$SUB_OT
HOST_OT=1
HOST_DO=255


if [[ $(id -nu) != 'root' ]]; then
	echo "Trebyetsya zapusk s pravami ROOT"
	exit 1
fi;

message() {
	echo "***********************************************************"
	echo -e "INTERFACE=$INTERFACE\nPREFIX=$PREFIX\nSUBNET=$SUB_OT..$SUB_DO\nHOST=$HOST_OT..$HOST_DO"
	echo ">>> Programa gotova k zapusku <<<"
	echo "[1] Izmenit SUBNET [2] Izmenit HOST [3] Zapustit programmu [4] Exit"
}


echo "******************************************************************************************************"
echo "Dlya korrektnoi raboti programmi vvedite INTERFACE, PREFIX (0-255.0-255), SUBNET (0-255), HOST (0-255)"
echo "INTERFACE - obyazatelnyi parametr, kotoryi zadaetsya v stroke zapyska programmi"
echo "******************************************************************************************************"

if [[ ( -z $INTERFACE ) ]]; then
	echo "Ne zadan obyazatenyi parametr zapyska INTERFACE!";
	exit 1;
fi;

echo -e "INTERFACE=$INTERFACE\nPREFIX=$PREFIX\nSUBNET=$SUB_OT..$SUB_DO\nHOST=$HOST_OT..$HOST_DO"
echo ">>> Programa gotova k zapusku <<<"

select opt in 'Izmenit SUBNET' 'Izmenit HOST' 'Zapustit programmu' 'Exit'; do
	case $opt in
        "Exit")
        	exit 1
	;;
	"Izmenit SUBNET")
		read -p "SUBNET OT=" SUB_OT;
		read -p "SUBNET DO=" SUB_DO;
		message
	;;
	"Izmenit HOST")
		read -p "HOST OT=" HOST_OT;
		read -p "HOST DO=" HOST_DO;
		message;
	;;
	"Zapustit programmu")
		for ((i=SUB_OT;i<SUB_DO+1;i+=1)) do
			for  ((j=HOST_OT;j<HOST_DO+1;j+=1)) do
				echo "[*] IP : ${PREFIX}.${i}.${j}"
				arping -c 3 -i "$INTERFACE" "${PREFIX}.${i}.${j}" 2> /dev/null
			done
	    	done
		message;
		;;
        *) echo "Nevernaya komanda";;
	esac
done