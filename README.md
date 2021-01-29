# Descripcion 

Estos plugins estan hechos para los servidores de Nsoporte asi como las localizaciones de archivos, puede que no funcione en otras diestros

# Instalacion 

## Centos 7

- wget "https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/751/RHEL_CentOS/pandorafms_agent_unix-7.0NG.751.noarch.rpm/download" -O /usr/src/pandorafms_agent_unix-7.0NG.751.noarch.rpm
-  yum install perl-YAML-Tiny git
- rpm -i /usr/src/pandorafms_agent_unix-7.0NG.751.noarch.rpm 
- systemctl enable pandora_agent_daemon
- git clone https://github.com/NSOPORTEDESARROLLO/pandorafms-plugins /usr/src/pandora
- mv /etc/pandora /etc/pandora.new
- mv /usr/src/pandora /etc
- chmod +x /etc/pandora/plugins/*

## Debian 9/10

- wget "https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/751/Debian_Ubuntu/pandorafms.agent_unix_7.0NG.751.deb/download" -O /usr/src/pandorafms.agent_unix_7.0NG.751.deb
- apt-get update
- apt-get install -y unzip zip git libyaml-tiny-perl
- dpkg -i /usr/src/pandorafms.agent_unix_7.0NG.751.deb
- systemctl enable pandora_agent_daemon
- git clone https://github.com/NSOPORTEDESARROLLO/pandorafms-plugins /usr/src/pandora
- mv /etc/pandora /etc/pandora.new
- mv /usr/src/pandora /etc
- chmod +x /etc/pandora/plugins/*

# Configuracion 

- Se debe revisar el archivo /etc/pandora/pandora_agent.conf
- Activar o Desactivar los archivos en el directorio "/etc/pandora/nsoporte" los archivos activos se deben activar cambiado la extension a .conf, los desactivados pueden ser .conf.no
- /etc/init.d/pandora_agent_daemon restart


## Windows 

- Descargar: https://sourceforge.net/projects/pandora/files/Pandora%20FMS%207.0NG/751/Windows/Pandora%20FMS%20Windows%20Agent%20v7.0NG.751_x86_64.exe/download


# Reparar el Plugin de CPU LOAD WINDOWS 

```
# Cpu Load

#CPU LOAD
module_begin
module_name  CPU Load
module_type generic_data 
module_exec wmic cpu get loadpercentage |grep -v Load
module_description  User CPU Usage (%)
module_min_warning 70
module_max_warning 90
module_min_critical 91
module_max_critical 100
module_unit %
module_group System
module_end

```




# Plugins 

- calls_by_trunk.pl: Especifica cuantas llamadas hay en una troncal, utiliza asterisk manager y se deben pasar parametros: port, host, user, pwd y trunk 
- icmp.pl: Permite saber la latencia entre un host, --host  Host para realizar la prueba ping, -count Cuantas pruebas se realizan, por defecto son 3, --timeout Segundos para esperar un timeout, por defecto 1s


