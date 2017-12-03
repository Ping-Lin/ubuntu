#!/usr/bin/perl

# Complain about undeclared variables
use strict;
use File::Basename;

my $VERSION = 1.0;
my $do_exts = 1;
my @tags = ();

# Create a tag file line and push it on the list of found tags
sub MakeTag($$$$)
{#{{{
	my ($tag, $type, $file, $line) = @_;
	my $tagline = "";   # Created tag line

	return unless $tag;
		
	chomp $line;
	$line =~ s/\\/\\\\/g;
	$line =~ s/\//\\\//g;
	$line =~ s/\*/\\\*/g;
	# Create a tag line
	$tagline = "$tag\t$file\t/^$line\$/";
	# If we're told to do so, add extensions
	$tagline .= ";\"\t$type" if ($do_exts);
	# Push it on the stack
	push (@tags, $tagline);
}#}}}

sub MakeFileTag($$$)
{#{{{
	my ($tag, $type, $file) = @_;
	my $tagline = "";
	return unless $tag;
	# Create a tag line
	$tagline = "$tag\t$file\t/^/";
	# If we're told to do so, add extensions
	$tagline .= ";\"\t$type" if ($do_exts);
	# Push it on the stack
	push (@tags, $tagline);
}#}}}

# Loop through files on command line - 'glob' any wildcards, since Windows
# doesn't do this for us
for my $file (map { glob } @ARGV)
{
	# Skip if this is not a file we can open.  Also skip tags files and backup
	# files
	next unless ((-f $file) && (-r $file) && ($file !~ /tags$/)
		&& ($file !~ /~$/));
	next if $file =~ /txti$/;

	print STDERR "Tagging file $file...\n";

	open (IN, $file) or die "Can't open file '$file': $!";

	my $fkey = lc(basename($file));
	$fkey =~ s/\.[^\.]+$//;
	$fkey =~ s/ /_/g;
	MakeFileTag($fkey, "p", $file);

	# Loop through file
	for my $line (<IN>)
	{
		if ($line =~ /^(==+)([^=]+)\1$/) {
			my $tkey = lc($2);
			$tkey =~ s/^\s*/#/;
			$tkey =~ s/\s*$//;
			$tkey =~ s/ /_/g;
			$tkey =~ s/\*/\\\*/g;
			MakeTag($fkey.$tkey, "f", $file, $line);

			if ($line =~ /======/) {
				MakeTag(substr($tkey,1), "f", $file, $line);
			}
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

	print "\nWriting tags file.\n";

	open (OUT, ">tags") or die "Can't open tags file: $!";

	for my $tagline (sort @tags)
	{
		print OUT "$tagline\n";
	}

	close (OUT);
}
else
{
	print "\nNo tags found.\n";
}
