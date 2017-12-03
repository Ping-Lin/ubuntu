#!/usr/bin/env perl

use strict;
use warnings;

my $prev_line = '';
my $line = '';
my $enter_code_block = 0;

printf "file: %s\n", $ARGV[0];

while (<>) {
	chomp;
	$line = $_;

	if ($line =~ /^\s*>?\s*```/) {
		$enter_code_block = !$enter_code_block;
	}

	if (!$enter_code_block) {
		if ($line =~ /^\s*=+\s*$/ and $prev_line ne '') {
			printf "$prev_line [%d]\n", $. - 1;
		} elsif ($line =~ /^\s*-+\s*$/ and $prev_line ne '') {
			printf "  $prev_line [%d]\n", $. - 1;
		} elsif ($line =~ /^\s*#\s*(\w+.*)$/) {
			printf "$1 [%d]\n", $.;
		} elsif ($line =~ /^\s*##\s*(\w+.*)$/) {
			printf "  $1 [%d]\n", $.;
		} elsif ($line =~ /^\s*###\s*(\w+.*)$/) {
			printf "    $1 [%d]\n", $.;
		} elsif ($line =~ /^\s*####\s*(\w+.*)$/) {
			printf "      $1 [%d]\n", $.;
		}
	}

	$prev_line = $line;
}
