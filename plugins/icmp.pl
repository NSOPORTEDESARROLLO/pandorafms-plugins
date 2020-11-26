#!/usr/bin/perl 

use Getopt::Long qw(GetOptions);


GetOptions ('host=s' => \$host,
	'count=s' => \$count,
	'timeout=s' => \$timeout,	
	);



sub PrintHelp {


	print "./icmp.pl --host Host_Name --count 4 --timeout 1 \n\n\n";
	print "--host  Host para realizar la prueba ping \n";
	print "--count Cuantas pruebas se realizan, por defecto son 3 \n";
	print "--timeout Segundos para esperar un timeout, por defecto 1s \n";
	#print "--help  Imprime esta ayuda \n"; 


	exit 0;

}


#Validando datos
if ( "$host" == "" ){

	&PrintHelp();

}

if ( "$count" == "" ) {

	$count = 3;
}

if ( "$timeout" == "" ) {

        $timeout = 1;
}





my @DATA = `ping $host -c $count -W $timeout |grep "bytes from" |awk '{print \$7}' |cut -d "=" -f2`;

for $w (@DATA) {

	$full +=$w;

}

my $dtotal = $full/$count;

my $total = sprintf("%.2f", $dtotal); 


#Salida de datos para Pandora FMS
print "<module>\n";
print "<name><![CDATA[ ICMP to Host: $host ]]></name>\n";
print "<type><![CDATA[generic_data]]></type>\n";
print "<data><![CDATA[ $total ]]></data>\n";
#print "<description>Latency in milliseconds host: $host</description>\n";
print "<module_group>Networking</module_group>\n";
print "</module>\n";
