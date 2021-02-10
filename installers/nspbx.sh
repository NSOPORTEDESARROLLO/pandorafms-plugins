#!/bin/bash

## Descargo pandora
echo -n "Obteniendo paquete de pandora........."
wget "https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/751/RHEL_CentOS/pandorafms_agent_unix-7.0NG.751.noarch.rpm/download" \
        -O /usr/src/pandorafms_agent_unix-7.0NG.751.noarch.rpm > /dev/null 2>&1

resp_wget=$?

if [ $resp_wget != 0 ];then

        echo "Error para bajar el paquete de pandora"
        exit 2

fi 

echo "Ok"

## Instalo dependencias
echo -n "Instalando dependencias ....................."
yum -y install perl-YAML-Tiny git > /dev/null 2>&1
resp_yum=$?

if [ $resp_yum != 0 ];then

        echo "Error para bajar las dependencias"
        exit 2

fi 

echo "Ok"

## Instalo pandora
echo -n "Instalando paquete de pandora ...................."
rpm -i /usr/src/pandorafms_agent_unix-7.0NG.751.noarch.rpm > /dev/null 2>&1
resp_rpmi=$?

if [ $resp_rpmi != 0 ];then

        echo "Error al instalar paquete de pandora"
        exit 2

fi  

systemctl enable pandora_agent_daemon
echo "Ok"

## Descargo scripts de Github
echo -n "Obteniendo los plugins de NSOPORTE ....................."
git clone https://github.com/NSOPORTEDESARROLLO/pandorafms-plugins /usr/src/pandora > /dev/null 2>&1
resp_git=$? 

if [ $resp_git != 0 ];then

        echo "Error al obtener el repositorio git"
        exit 2

fi  


mv /etc/pandora /etc/pandora.new
mv /usr/src/pandora /etc
chmod +x /etc/pandora/plugins/*
echo "Ok"

##Activando Plugins
echo -n "Activando plugins .................."
mv /etc/pandora/nsoporte/httpd.conf.no /etc/pandora/nsoporte/httpd.conf
mv /etc/pandora/nsoporte/dialerd.conf.no /etc/pandora/nsoporte/dialerd.conf

echo "Ok"

##Revisando Shorewall
echo -n "Revisando si shorewall esta instalado ...................."
if [ -f "/usr/sbin/shorewall" ] || [ -f "/usr/bin/shorewall" ];then 

        echo "Ok"


else 
        echo "Fallo"
        echo -n "Buscando si shorewall usa docker ......................"
        dkr=$(docker ps |grep nsfirewall |wc -l)
        if [ $dkr != 0 ];then
                echo "Ok"
        fi

        echo -n "Creando el acceso directo ............................"
        echo '#!/bin/bash

docker exec -i nsfirewall shorewall $1 $2 $3 $4 $5 $6 $7

exit 0' > /usr/sbin/shorewall 

        chmod +x /usr/sbin/shorewall
        ln -s /usr/sbin/shorewall /usr/bin/
        echo "Ok"

fi

#### Reinicio servicio
echo -n "Levantando servicio de pandora ................."
/etc/init.d/pandora_agent_daemon restart
echo "Ok"








