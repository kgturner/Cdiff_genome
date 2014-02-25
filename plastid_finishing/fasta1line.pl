#!/usr/bin/perl -w
use strict;
my $line1 = 1;
while(<STDIN>){
	my $line = "$_";
	chomp $line;
	if($line1==1){
		print "$line\n";
		$line1=0;
	}	
	else{
		if($line =~ m/^>/){
			print "\n$line\n";	
		}	
		else{
			print "$line";	
		}
	}
}
print "\n";
