#!/usr/bin/env perl

use strict;
use warnings;

# Used modules
use Getopt::Long;
use File::Basename;

# Options with their defaults
my $do_subs = 1;    # --subs, --nosubs    include subs in tags file?
my $do_vars = 1;    # --vars, --novars    include variables in tags file?
my $do_pkgs = 1;    # --pkgs, --nopkgs    include packages in tags file?
my $do_exts = 1;    # --extensions, --noextensions
		    #			  include Exuberant Ctags extensions

# Global variables
my $VERSION = "0.1";	# pltags version
my $status = 0;		# GetOptions return value
my $file = "";		# File being processed
my @tags = ();		# List of produced tags
my $is_pkg = 0;		# Are we tagging a package?
my $has_subs = 0;	# Has this file any subs yet?
my $package_name = "";	# Name of current package
my $var_continues = 0;	# Variable declaration continues on last line
my $line = "";		# Current line in file
my $stmt = "";		# Current Perl statement
my @vars = ();		# List of variables in declaration
my $var = "";		# Variable in declaration
my $tagline = "";	# Tag file line
my $curr_class = "";

# Create a tag file line and push it on the list of found tags
sub MakeTag($$$$$@)
{
    my ($tag,		# Tag name
	$type,		# Type of tag
	$is_static,	# Is this a static tag?
	$file,		# File in which tag appears
	$line,		# Line in which tag appears
	$extdata) = @_;	# extend data

    my $tagline = "";   # Created tag line

    # Only process tag if not empty
    if ($tag)
    {
	# Get rid of \n, and escape / and \ in line
	chomp $line;
	$line =~ s/\\/\\\\/g;
	$line =~ s/\//\\\//g;

	# Create a tag line
	$tagline = "$tag\t$file\t/^$line\$/";

	# If we're told to do so, add extensions
	if ($do_exts)
	{
	    $tagline .= ";\"\t$type"
			    . ($is_static ? "\tfile:" : "")
			    . ($package_name ? "\tclass:$package_name" : "")
			    . ($extdata ? "\t".$extdata : "");
	}

	# Push it on the stack
	push (@tags, $tagline);
    }
}

############### Start ###############

# Get options
$status = GetOptions("subs!" => \$do_subs,
		     "vars!" => \$do_vars,
		     "pkgs!" => \$do_pkgs,
		     "extensions!" => \$do_exts);

# Usage if error in options or no arguments given
unless ($status && @ARGV)
{
    print "\n" unless ($status);
    print "  Usage: $0 [options] filename ...\n\n";
    print "  Where options can be:\n";
    print "    --subs (--nosubs)     (don't) include sub declarations in tag file\n";
    print "    --vars (--novars)     (don't) include variable declarations in tag file\n";
    print "    --pkgs (--nopkgs)     (don't) include package declarations in tag file\n";
    print "    --extensions (--noextensions)\n";
    print "                          (don't) include Exuberant Ctags / Vim style\n";
    print "                          extensions in tag file\n\n";
    print "  Default options: ";
    print ($do_subs ? "--subs " : "--nosubs ");
    print ($do_vars ? "--vars " : "--novars ");
    print ($do_pkgs ? "--pkgs " : "--nopkgs ");
    print ($do_exts ? "--extensions\n\n" : "--noextensions\n\n");
    print "  Example: $0 *.pl *.pm ../shared/*.pm\n\n";
    exit;
}

# Loop through files on command line - 'glob' any wildcards, since Windows
# doesn't do this for us
foreach $file (map { glob } @ARGV)
{
    # Skip if this is not a file we can open.  Also skip tags files and backup
    # files
    next unless ((-f $file) && (-r $file) && ($file !~ /tags$/)
		 && ($file !~ /~$/));

    print "file: $file\n";

    $is_pkg = 0;
    $package_name = "";
    $has_subs = 0;
    $var_continues = 0;

    open (IN, $file) or die "Can't open file '$file': $!";

    my $ln = 0;
    # Loop through file
    foreach $line (<IN>)
    {
	$ln ++;
	my $id = qr{[_\-a-zA-Z][_\-a-zA-Z0-9]*};

	# Statement is line with comments and whitespace trimmed
	($stmt = $line) =~ s{//.*}{};
#	$stmt =~ s/^\s*//;
	$stmt =~ s/\s*$//;
	#FIXME skip "/* ... */" comment

	# Nothing left? Never mind.
	next unless ($stmt);

	# s => sub, v => veriable, p => package

#	if ($stmt =~ /\<function\>\s*([_\-a-zA-Z][_\-a-zA-Z0-9]*)\s*\(/) {
#		MakeTag($1, "s", 1, $file, $line);
#	}

	if ($stmt =~ /^\t($id):\s*function/) {
		MakeTag($1, "s", 1, $file, $line, "class:$curr_class");
		print "  $1 () [$ln]\n";
	}

	if ($stmt =~ /^\t($id):\s*{/) {
		MakeTag($1, "s", 1, $file, $line, "class:$curr_class");
		print "  $1 {Obj} [$ln]\n";
	}

	if ($stmt =~ /($id)\s*=\s*Ext\.extend\s*\(($id(\.$id)*),/) {
		MakeTag($1, "v", 1, $file, $line);
		$curr_class = $1;
		print "$1 <- $2 [$ln]\n"
	}

	if ($stmt =~ /^\s*Ext\.define\s*\(['"]($id(.$id)*)['"]\s*,.*/) {
		MakeTag($1, "v", 1, $file, $line);
		$curr_class = substr($2, 1);
		print "$curr_class <- ? [$ln]\n"
	}

	if ($stmt =~ /^($id\.)*($id)\s*=\s*\{\s*$/) {
		MakeTag($2, "v", 1, $file, $line);
		$curr_class = $2;
		print "$2 {Obj} [$ln]\n"
	}
    }
    close (IN);
}

# Do we have any tags?  If so, write them to the tags file
if (@tags)
{
    # Add some tag file extensions if we're told to
    if ($do_exts)
    {
	push (@tags, "!_TAG_FILE_FORMAT\t2\t/extended format/");
	push (@tags, "!_TAG_FILE_SORTED\t1\t/0=unsorted, 1=sorted/");
	push (@tags, "!_TAG_PROGRAM_AUTHOR\tMichael Schaap\t/mscha\@mscha.com/");
	push (@tags, "!_TAG_PROGRAM_NAME\tpltags\t//");
	push (@tags, "!_TAG_PROGRAM_VERSION\t$VERSION\t/supports multiple tags and extended format/");
    }

    #print STDERR "\nWriting tags file.\n";

#    open (OUT, ">tags") or die "Can't open tags file: $!";

#       foreach $tagline (sort @tags)
#    {
#	print OUT "$tagline\n";
#    }

#    close (OUT);
}
else
{
    print "\nNo tags found.\n";
}
