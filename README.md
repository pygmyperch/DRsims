# DRsims
 Code to run the eco-evolutionary simulations for the paper:
 
 Attard et al. (in prep) Fish out of water: eco-evolutionary dynamics of rainbowfish populations in the desert.
 
## To run the simulations:

Download the repo [here](https://github.com/pygmyperch/DRsims/archive/master.zip)

\
The top directory DRsimulations/ contains shell scripts to run replicates for each simulation model,<br />
and bin/ that contains functions and scripts used to run SLiM, process the data and generate the figures<br />

\
cd into DRsimulations/ then simply run:

```
./run_NeXXX_SXX_MXX_CXXX.sh

```

\
Replacing **run_NeXXX_SXX_MXX_CXXX.sh** with simulation model you want to run.<br />



\
The code is ugly :dizzy_face: but it works (tested on MacOS). You will need to ensure R, perl, SLiM and vcftools are installed.
\
I think it should also work on most linux distros but you will need to change gcsplit to csplit in bin/process_SLiM_vcf.sh 
