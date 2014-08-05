#!/usr/bin/perl -w
# jogsoul.pl v1.1
# usage: jogsoul.pl [configuration file location]

use strict;
use IO::Socket;
use Digest::MD5;

my $sd;
my $server = "ns-server.epita.fr";
my $port = "4242";
my $conf_file = "/tmp/jogsoul.conf";
my $login;
my $pass;
my $data = "none";
my $location = "none";
my $logfile;

sub	parse
{
    my  @tab;

    while (<FILE>)
    {
        chomp($_);
        last if (substr($_, 0, 1) eq ":" || substr($_, 0, 1) eq "#" || substr($_, 0, 1) eq "") || ($_ =~ /^\s*(\#.*)?$/);
        push(@tab, $_);
    }
    return (@tab);
}

sub	print_error
{
    print STDERR "[ERROR]: $_[0]\n";
    print_log("[ERROR]: $_[0]");
    exit(1);
}

sub	print_warning
{
    print STDERR "[WARNING]: $_[0]\n";
    print_log("[WARNING]: $_[0]");
}

sub	print_log
{
    open(LOG, ">>$logfile") or print STDERR "Cannot open $logfile for writing logs\!";
    print LOG "$_[0]\n";
    close(LOG);
}

sub     ns_encode
{
    my ($str) = @_;
    chomp($str);
    $str =~ s[\n][\\n]g;
    $str =~ s/([^a-zA-Z0-9_.\-\\])/sprintf("%%%02X", ord($1))/ge;
    $str =~ tr/ /+/;
    return $str;
}

sub	getconf()
{
    $conf_file = $ARGV[0] if ($#ARGV == 0);
    print "-- Getting jogsoul configuration (in $conf_file). --\n";
    open(FILE, $conf_file) or print_error("Cannot open $conf_file");
    while (<FILE>)
    {
	chomp($_);
	if (substr($_, 0, 1) ne '#' && substr($_, 0, 1) ne "\n")
	{
	    $server = <FILE> if ($_ eq ":server");
	    $port = <FILE> if ($_ eq ":port");
	    $logfile = <FILE> if ($_ eq ":logfile");
	    $login = <FILE> if ($_ eq ":login");
	    $pass = <FILE> if ($_ eq ":pass");
	    $location = <FILE> if ($_ eq ":location");
	    $data = <FILE> if ($_ eq ":data");
	}
    }
    close(FILE);
    print_error("Missing server\!") if (!$server);
    print_error("Missing port for connection to server\!") if (!$port);
    print_error("Missing logfile path\!") if (!$logfile);
    print_error("Missing login\!") if (!$login);
    print_error("Missing pass\!") if (!$pass);
    print_error("location field too long (must be < 64 char)") if (length($location) > 64);
    print_error("data field too long (must be < 64 char)") if (length($data) > 64);
    $location = ns_encode($location);
    $data = ns_encode($data);
    chomp($server);
    chomp($port);
    chomp($logfile);
    chomp($login);
    chomp($pass);
}

sub	ns_connect
{
    print_log "Connection to $server on port $port";
    close($sd) if (defined($sd));
    $sd = 0;
    while (!$sd)
    {
	$sd = IO::Socket::INET->new(Proto => "tcp",
				    PeerAddr => $server,
				    PeerPort => $port,
				    Timeout => 5);
	if (!$sd)
	{
	    print_warning("Cannot connect to $server on port $port");
	    sleep(1);
	}
    }
}

sub	ns_auth
{
    my	$chain;
    my	$rep;
    my	$hash;
    my	$ctx;

    $chain = ns_read();
    chomp($chain);
    ns_write("auth_ag ext_user none none");
    $rep = ns_read();
    chomp($rep);
    print_error("Authentication query does not succeed") if ($rep ne "rep 002 -- cmd end");
    my ($salut, $nfd, $secret, $host, $port, $timestamp) = split(' ', $chain);
    $ctx = Digest::MD5->new;
    $ctx->add("$secret-$host/$port$pass");
    $hash = $ctx->hexdigest;
    ns_write("ext_user_log $login $hash $location $data");
    $rep = ns_read();
    chomp($rep);
    print_error("Authentication does not succeed") if ($rep ne "rep 002 -- cmd end");
    print_log("Authentication succeed");
}

sub     ns_read
{
    my $line;
    my $cnt = 10;

    connection() if (!defined($sd));
    while (!($line = <$sd>))
    {
	print_warning("Failed to read, retrying ($cnt) ...");
        sleep(1);
	$cnt--;
	if (!$cnt)
	{
	    $cnt = 10;
	    connection();
	}
    }
    chomp($line);
    return ($line);
}

sub     ns_write
{
    my $text = $_[0];

    chomp($text);
    print $sd "$_[0]\n";
}

sub	connection
{
    &ns_connect();
    &ns_auth();
}

sub	loop()
{
    while (42)
    {
	my $event_line = ns_read();
	chomp($event_line);
	my @event = split(' ', $event_line);
	if ($event[0] eq "ping")
	{
	    print_log("receive a ping ($event[1])");
	    ns_write("$event[0] $event[1]");
	}
	elsif ($event[0] eq "user_cmd")
	{
	    print_log("receive a message (parse it yourself if you want to reed it)");
	}
	else
	{
	    print_log("receive an unkown command: $event_line");
	}
    }
}

sub	deamonize()
{
    fork && exit;
    close(STDOUT);
    close(STDIN);
    close(STDERR);
}

sub	main
{
    &deamonize();
    &getconf();
    &connection();
    &loop();
}

&main();
