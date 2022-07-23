#! /bin/bash

salida=$? #nos facilita la gestion
if [ $# -ge 2 ] &&  [[ -d $1 ]]; then #se compara si el nº de args es mayor o igual que 2 y que el DIR destino ($1) es un directorio  
    for i in $@     #recorremos con un for cada uno de los args pasados
    do
        if [[ "$i" == "$1" ]]; then #llamamos al primer argumento "destino", ademas, es útil ya que no interesa iterar sobre el primer arg
            destino=$1
        else
            if  [[ -d $i ]]; then #se comprueba que el arg pasado como DIR origen son realmente directorios y se puede acceder a ellos
                for fileO in `ls $i` #se empieza a iterar sobre cada elemento que haya en ese directorio
                do
                    if [ -f $i/$fileO ] #se comprueba si dicho elemento es un archivo
                    then
                        if [ -d $destino$fileO ];then  #se comprueba si existe un directorio (en $1) con el nombre del archivo que se está iterando
                            #si existe, se saca un mensaje de error, pero se continuan las siguientes iteraciones
                            echo -e "ERROR(): Hay un directorio en el >> Directorio Destino: $destino << que tiene el mismo nombre que un archivo del >>Directorio Origen: $i$fileO <<. \n"
                        else #en caso contrario, se copia el archivo al directorio elegido, -p mantiene los datos, -u realiza la copia si es mas   actual que otro posible archivo con el mismo nombre
                            cp -pu $i$fileO $destino
                        fi
                    fi
                done
            else # Mensaje de error por si un args no era un directorio, ademas indica el nombrede cual en color.
                echo -e "ERROR(2): El argumento: \033[32m"$i"\e[0m no es un directorio y fue omitido"
                salida=2  # ahora exit=2, y por lo cual $?=2
            fi
        fi
    done
else #no se han pasado 2 o mas argumentos, o el primer directorio (destino) no era un directorio.
    echo "ERROR (1): Se necesita dos o mas argumentos, el primero debe ser el >> Directorio_Destino << y los siguientes los >> Directorios_Origen <<, de los cuales se copiarán los archivos"
    salida=1 # ahora exit=1, y por lo cual $?=1
fi
exit $salida #manda un exit con codigo=salida