#!/usr/bin/perl 

use Asterisk::AMI;
use Getopt::Long qw(GetOptions);


sub help {

print "
Error: Script usage:\ncheck_calls_trunk --port 5038 --user some_user --pwd password --trunk trunh_name -f 30 -w 10 -c 20\n

Where:
	--port = Asterisk ami port
	--host = Asterisk ami host or IP
	--user = Asterisk ami user 
	--pwd = Asterisk ami password
	--trunk = Trunk name to check channels
	-f = Max calls by trunks, for example PRI E1 29
	-w = Warning value (numeric)
	-c = Critical value (Numeric)

Critical must be greater than Warning value and full value must be grater than Critical and Warning value.\n";


exit 3;	


}


GetOptions ('trunk=s' => \$trunk,
	'user=s' => \$user,
	'pwd=s' => \$pwd,
	'host=s' => \$host,
	'port=s' => \$port,
	'w=s' => \$w,
	'c=s' => \$c,
	'f=s' => \$f
	
	);


#Validar informacion 
if ($trunk eq ""  && $user eq ""  && $pwd eq "" && $host eq "" && $f eq "" && $w eq "" && $c eq "") {

	help();

}
	


my $astman = Asterisk::AMI->new(PeerAddr => $host,
                                PeerPort => $port,
                                Username => $user,
                                Secret => $pwd
                        );
 
die "Unable to connect to asterisk" unless ($astman);
 
my $action = $astman->send_action({ Action => 'Command',
                         Command => 'sip show channels'
                        });

my $resp = $astman->get_response($action);
my %INFO = %{$resp};
my @CMD = @{$INFO{'CMD'}};

my @SP=grep(/$trunk/, @CMD);
my @FILTER=grep(!/nothing/, @SP);

my $channels = 0;

for my $line (@FILTER) {

	#print "$line\n";

	$channels++;
}


#Desconecto de AMI
$astman->disconnect();


#Salida de datos para Pandora FMS
print "<module>\n";
print "<name><![CDATA[ Calls Per Trunk: $trunk ]]></name>\n";
print "<type><![CDATA[generic_data]]></type>\n";
print "<data><![CDATA[ $channels ]]></data>\n";
print "<description>Number of calls by Trunk: $trunk</description>\n";
print "</module>\n";

