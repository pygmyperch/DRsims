#!/usr/bin/perl
use strict;
use warnings; 

use File::Find;
use File::chdir;

my @files;
my $file;
my $line;

my $outfile = 'allfst.txt';
my @folders = grep -d, glob '*';

my $result_path = "$CWD/fst";
mkdir $result_path;

for my $folder ( @folders ) {
  my $result_folder = "$result_path/$folder";
  mkdir $result_folder;
  local $CWD = $folder;

#@files = File::Find::Rule->file()->name("*.vcf.log")->in(".");


find(\&wanted, ".");
sub wanted
{
    push(@files, $File::Find::name) if($File::Find::name=~m/\.(vcf.log)$/i);
}


foreach my $file (@files) {
   open (FILE, $file) || die "Can't open file \"$file\".\n";
   open (OUT, ">> $result_folder/$outfile") || die "problem opening $outfile\n";

while($line = <FILE>) {

	print OUT "$line" if $line =~ /weighted/;

		}
		close(OUT);
		close(FILE);
	}
}


