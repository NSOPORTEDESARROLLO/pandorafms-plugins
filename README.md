## Descripcion 

Estos plugins estan hechos para los servidores de Nsoporte asi como las localizaciones de archivos, puede que no funcione en otras diestros

## Instalacion 

# Centos 7

- wget "https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/743/RHEL_CentOS/pandorafms_agent_unix-7.0NG.743-1.noarch.rpm/download" -O /usr/src/pandorafms_agent_unix-7.0NG.743-1.noarch.rpm
-  yum install perl-YAML-Tiny git
- rpm -i /usr/src/pandorafms_agent_unix-7.0NG.743-1.noarch.rpm 
- git clone https://github.com/NSOPORTEDESARROLLO/pandorafms-plugins /usr/src/pandora
- mv /etc/pandora /etc/pandora.new
- mv /usr/src/pandora /etc



## Configuracion 

- Se debe revisar el archivo /etc/pandora/pandora_agent.conf
- Activar o Desactivar los archivos en el directorio "/etc/pandora/nsoporte" los archivos activos se deben activar cambiado la extension a .conf, los desactivados pueden ser .conf.no
- /etc/init.d/pandora_agent_daemon restart