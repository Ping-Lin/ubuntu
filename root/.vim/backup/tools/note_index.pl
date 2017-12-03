#!/usr/bin/perl

# Complain about undeclared variables
use strict;
use File::Basename;

my $VERSION = 1.0;
my $do_exts = 1;
my @tags = ();
my @input_files = ();

my $is_qf = 0; # flag for vim quick fix mode

for (@ARGV) {
	if ('--qf' eq $_) {
		$is_qf = 1;
	} else {
		push @input_files, $_;
	}
}

print "# vim:ft=note\n" unless $is_qf;

# Loop through files on command line - 'glob' any wildcards, since Windows
# doesn't do this for us
for my $file (map { glob } @input_files)
{
	# Skip if this is not a file we can open.  Also skip tags files and backup
	# files
	next unless ((-f $file) && (-r $file) && ($file !~ /tags$/)
		&& ($file !~ /~$/));

	next if $file eq "index.txt";
	next if $file =~ /txti$/;
	open (IN, $file) or die "Can't open file '$file': $!";

	my ($fkey,$cline) = (basename($file), 0);
	$fkey =~ s/\.[^\.]+$//;
	$fkey =~ join " ", map{ uc($_) } split(/_/, $fkey);

	print "===== index of [[", $fkey, "]] =====\n" unless $is_qf;

	# Loop through file
	for my $line (<IN>)
	{
		$cline ++;

		if ($line =~ /^(==+)([^=]+)\1$/) {
			my $indent = 6 - length($1);
			my $tkey = $2;
			$tkey =~ s/^\s*//;
			$tkey =~ s/\s*$//;

			if ($is_qf) {
				if ($indent == 0) {
					print "$tkey [$cline]\n";
				} else {
					print "  " x $indent, "$tkey [$cline]\n";
				}
			} else {
				if ($indent == 0) {
					print "[[$fkey#$tkey]]\n";
				} else {
					print "  " x $indent, "* [[", $fkey, "#", $tkey, "]]\n";
				}
			}
		}
	}
	close (IN);
}

