#!/usr/bin/perl
##
##  File							: dwmStatusBar.pl
##	 Path							: /usr/local/perso/dwmStatusBar.pl
##  Created by					: Pierre Za_warudo SAILLARD
##  Login						: dio
##
##  Started						: [Fri 14 Oct 2016 22:01:17]
##  Last modification		: [Fri 14 Oct 2016 22:01:58]
##

use strict;
use warnings;
use POSIX qw(strftime);

=begin getline
read a set number of lines from the beginning of a file
getline(path, nb)
path = path to the file to read
nb	= number of line to read
=cut

sub getline()
{
	my $buffer;
	my $argNum = @_;
	if ($argNum != 2)
	{
		print 
		"getline(FILEPATH, LINENUM)
		FILEPATH 	= path to the file you want to read
		LINENUM 	= how many lines do you want to read from the file?";
	}
	else
	{
		my $it;
		my $line = "";
		open(FILE, "<".$_[0]) or die "Failed to open \"$_[0]\" => $!\n";
		for ($it = 0; ($it < $_[1]) and defined($line = readline(FILE)); $it++)
		{
			if (defined ($buffer))
			{
				$buffer = $buffer.$line;
			}
			else
			{
				$buffer = $line;
			}
		}
		close(FILE);
	}
	return ($buffer);
}

while (1)
{
	my $batCapacity = &getline("/sys/class/power_supply/BAT0/capacity", 1);
	my $batStatus = &getline("/sys/class/power_supply/BAT0/status", 1);
	chomp $batStatus;
	chomp $batCapacity;
	my $localtime = strftime("Date=[%A %e %B] Time=[%X]\n", localtime);
	system("xsetroot -name \"Battery=[$batCapacity\% $batStatus] $localtime\"");
	sleep(1);
}

