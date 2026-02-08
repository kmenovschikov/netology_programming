#!/bin/bash
INTERFACE=$1
PREFIX=$2

if [[ -z $3 ]]; then
	SUB_OT=1;SUB_DO=255
else
	if [[ $3 =~ ^(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$ ]]; then
		SUB_OT=$3;SUB_DO=$3
	else
		echo "ZNACHENIE SUBNET NE SOOTVETSTVUET INTERVALU 0..255"
		exit
	fi;
fi;

if [[ -z $4 ]]; then
	HOST_OT=1;HOST_DO=255
else
	if [[ $4 =~ ^(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$ ]]; then
		HOST_OT=$4;HOST_DO=$4
	else
		echo "ZNACHENIE HOST NE SOOTVETSTVUET INTERVALU 0..255"
		exit
	fi;
fi;

if [[ $(id -nu) != 'root' ]]; then
	echo "Trebyetsya zapusk s pravami ROOT"
	exit 1
fi;

echo "****************************************************************************************************************"
echo "Dlya korrektnoi raboti programmi zadaite parametri INTERFACE, PREFIX (0-255.0-255), SUBNET (0-255), HOST (0-255)"
echo "INTERFACE i PREFIX - obyazatelnye parametri"
echo "****************************************************************************************************************"

if [[ ( -z $INTERFACE ) || (! -z $INTERFACE && -z $PREFIX ) ]]; then
	echo "Ne zadany obyazatenyae parametri zapyska INTERFACE i PREFIX!";
	exit 1;
fi;

if [[ $PREFIX =~ ^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9]))$ ]]; then
	echo "OK"
else
	echo "ZNACHENIE PREFIX NE SOOTVETSTVUET INTERVALU 0..255.0..255"
	exit 1;
fi;

echo -e "INTERFACE=$INTERFACE\nPREFIX=$PREFIX\nSUBNET=$SUB_OT..$SUB_DO\nHOST=$HOST_OT..$HOST_DO"
echo ">>> Programa gotova k zapusku <<<"

for ((i=SUB_OT;i<SUB_DO+1;i+=1)) do
	for  ((j=HOST_OT;j<HOST_DO+1;j+=1)) do
		echo "[*] IP : ${PREFIX}.${i}.${j}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${i}.${j}" 2> /dev/null
	done
done