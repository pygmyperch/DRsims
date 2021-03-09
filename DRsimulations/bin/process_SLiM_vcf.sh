#!/bin/bash

for f in *; do mv "$f" "${f// /}"; done

mkdir -p sim_reps/
mkdir -p sim_meta/

for file in *.vcf; do mv "$file" sim_reps/; done

for file in *.meta; do gcsplit -k "$file" -f "$file" --suffix="_%02d.wet" -z /new_sim:/ {*}; rm "$file"; done;

mv *.wet sim_meta/

cd sim_reps/

for file in *.vcf; do mkdir -p -- "${file%%.*}" && mv -- "$file" "${file%%.*}"; done

for d in */ ; do ( cd "$d" && for f in *.vcf; do gcsplit -k "$f" -f "$f" --suffix="_%02d.vcf" -z /##fileformat=VCFv4.2/ {*}; rm "$f"; done; ); done

for d in */ ; do ( cd "$d" && for f in *.vcf; do mv "$f" "${f/.vcf_/_}"; done); done