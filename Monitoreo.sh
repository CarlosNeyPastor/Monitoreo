#!/bin/bash
clear
if [ $UID != 0 ];
then
echo "Solo el Administrador del sistema puede ejecutar este script"
sleep 5
exit
fi
fecha=`date | cut -d' ' -f2,3`
fecha_hora=`date | cut -d ' ' -f2,3,4,6`
opcion=0
until [ $opcion -eq 7 ];
do
echo "***SISTEMA DE MONITOREO***
Seleccione una opcion
1) Usuarios actualmente conectados al sistema
2) Usuarios que iniciaron sesion en el sistema
3) Consultar archivos modificados
4) Accesos fallidos al sistema
5) Uso del CPU
6) Uso de RAM
7) Salir"
read opcion
case $opcion in
1)clear
echo "***Usuarios actualmente conectados al sistema***"
echo -e
who | cut -d " " -f1
echo "Usuarios conectados al sistema en la fecha:$fecha_hora">>Registro_"$fecha"
who | cut -d " " -f1>>Registro_"$fecha"
;;
2)clear
echo "Usuarios que iniciaron sesion en el sistema"
echo -e
last -ain 5
echo "Usuarios que iniciaron en el sistema en la fecha:$fecha_hora">>Registro_"$fecha"
last -ain5>>Registro_"$fecha"
;;
3)clear
echo "Listado de archivos modificados en las ultimas 24hs"
echo -e
find /home -type f -mtime 0 -exec ls -gGh --full-time '{}' \; | cut -d ' ' -f 4,5,7
echo "Archivos modificados en la fecha:$fecha_hora">>Registro_"$fecha"
find /home -type f -mtime 0 -exec ls -gGh --full-time '{}' \; | cut -d ' ' -f 4,5,7>>Registro_"$fecha"
;;
4)clear
echo "Listado de inicio de sesion fallidos"
echo -e
lastb -ia
echo "Inicios de sesion fallidos en la fecha:$fecha_hora">>Registro_"$fecha"
lastb -ia>>Registro_"$fecha"
;;
5)clear
echo "Consumo actual de CPU"
echo -e
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
echo "Consumo de CPU en la fecha:$fecha_hora">>Registro_"$fecha"
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10>>Registro_"$fecha"
;;
6)clear
echo "Consumo actual de RAM"
echo -e
free -m
echo "Consumo de RAM en la fecha:$fecha_hora">>Registro_"$fecha"
free -m>>Registro_"$fecha"
;;
7)
exit
;;
*)clear
echo -e "¡ERROR!\nVerifique la opcion seleccionada"
esac
done
