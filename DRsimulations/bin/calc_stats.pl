#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Basename;

my $pop1 = $ARGV[0];
my $pop2 = $ARGV[1];
my $pop3 = $ARGV[2];
my @files;

my $base1 = basename($pop1);
my $base2 = basename($pop2);
my $base3 = basename($pop3);

my $prefix1 = $base1;
	$prefix1 =~ s/\.inds//;
my $prefix2 = $base2;
	$prefix2 =~ s/\.inds//;
my $prefix3 = $base3;
	$prefix3 =~ s/\.inds//;

{


find(\&wanted, ".");
sub wanted
{
    push(@files, $File::Find::name) if($File::Find::name=~m/\.(vcf)$/i);
}


foreach my $file (@files){

    my @cmd1 = ("vcftools", "--vcf", $file, "--freq2", "--keep", $pop1, "--out", $file.$prefix1);
	system("@cmd1");

	}

foreach my $file (@files){

    my @cmd2 = ("vcftools", "--vcf", $file, "--freq2", "--keep", $pop2, "--out", $file.$prefix2);
	system("@cmd2");

	}

foreach my $file (@files){

    my @cmd3 = ("vcftools", "--vcf", $file, "--freq2", "--keep", $pop3, "--out", $file.$prefix3);
	
	system("@cmd3");

	}

foreach my $file (@files){

	my @cmd4 = ("vcftools", "--vcf", $file, "--weir-fst-pop", $pop1, "--weir-fst-pop", $pop2, "--weir-fst-pop", $pop3, "--out", $file);

	system("@cmd4");

	}

}


