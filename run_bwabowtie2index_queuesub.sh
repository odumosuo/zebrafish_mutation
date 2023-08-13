#!/bin/sh

## Description: This script indexes the reference genome for bwa and bowtie software 
## Date: 05 May 2023

## How to run: sbatch run_bwabowtie2index_queuesub.sh genomename.fasta

## Notes: - will match .fa, .fasta, and .fna
##        - this script and reference genome need to be in the same directory
##        - account information on line 7 should be changed accordingly
##        - make sure run_bwabowtie2index_queuesub.sh is executable. use code: chmod +x run_bwabowtie2index_queuesub.sh

#SBATCH --account=def-lukens
#SBATCH --time=0-03:00:00 ## days hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --mem=16000 ## requested memory (in MB)
#SBATCH --ntasks-per-node=1 ## number of threads


module load bwa
module load bowtie2
echo $1

basename=`echo $1 | sed 's/\.f[a-z]*//g'`
echo $basename

echo "Running indexing for $1 with bwa"


bwa index -a bwtsw $1
echo "Done with bwa. Indexing for bowtie2."



bowtie2-build $1 $basename
echo "All done now"


