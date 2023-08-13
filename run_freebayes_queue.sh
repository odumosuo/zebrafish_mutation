#!/bin/sh

## Description: This script uses freebayes to perform variant calling on sorted, indexed and readgrouped bam files
## Date: 22 July 2023

## How to run: sbatch run_freebayes_queue.sh 

## Notes: - Run the command while in the directory with all .rg files i.e Bwa or Bowtie directory
##        - Make sure reference fasta is in the same directory
##        - make sure run_freebayes_queue.sh is executable. use code: chmod +x run_freebayes_queue.sh

#SBATCH --account=def-lukens
#SBATCH --time=0-06:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=32000 # requested memory (in MB)


# load module
module load nixpkgs/16.09 gcc/7.3.0 freebayes/1.2.0 java/1.8.0_192

# Make a file that has the file name of the bam files (with read groups) of samples as a line in a text file.
for file in ./*.rg; do echo $file >> Individuals_bam_readgroups_filename.txt; done

# run an unfiltered freebayes
freebayes -f ./zebrafish_genome_GRCz11_GCA_000002035.fna -L Individuals_bam_readgroups_filename.txt > unfiltered_freebayes_paired.vcf