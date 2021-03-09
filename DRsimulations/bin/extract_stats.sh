#!/bin/bash

# This script will parse the vcftools results files for each replicate dir in sim_reps/ and extract global Fst results 
# and calculate He for each subpopulation

# usage: ./extract_stats.sh


BASE=$(pwd)

mkdir -p pop1He/
mkdir -p pop2He/
mkdir -p pop3He/
mkdir -p fst/

cd sim_reps/


for d in $BASE/sim_reps/*/ ; do ( cd "$d" && for f in *pop1.frq; do awk 'FNR == 1 {next} {print $(NF-1),"\t",$NF}' $f | 
				awk '{ print 2* $1 * $2 }' | awk '{ total += $1; count++ } END { print total/count }' >> "$(basename "$(pwd)")".pop1 ; done); done

				mv `find . -name "*.pop1"` $BASE/pop1He/


for d in $BASE/sim_reps/*/ ; do ( cd "$d" && for f in *pop2.frq; do awk 'FNR == 1 {next} {print $(NF-1),"\t",$NF}' $f | 
					awk '{ print 2* $1 * $2 }' | awk '{ total += $1; count++ } END { print total/count }' >> "$(basename "$(pwd)")".pop2 ; done); done

				mv `find . -name "*.pop2"` $BASE/pop2He/


for d in $BASE/sim_reps/*/ ; do ( cd "$d" && for f in *pop3.frq; do awk 'FNR == 1 {next} {print $(NF-1),"\t",$NF}' $f | 
					awk '{ print 2* $1 * $2 }' | awk '{ total += $1; count++ } END { print total/count }' >> "$(basename "$(pwd)")".pop3 ; done); done

				mv `find . -name "*.pop3"` $BASE/pop3He/


for d in $BASE/sim_reps/*/ ; do ( cd "$d" && for f in *vcf.log; do grep -e 'weighted' "$f" >> "$(basename "$(pwd)")".txt ; done); done


				mv `find . -name "*.txt"` $BASE/fst/
				
				
				
		

