#!/bin/sh

## Description: This script uses bctool to perform variant calling on sorted and indexed bam files
## Date: 05 May 2023

## How to run: sbatch run_bcftools_variantcalling_queue.sh name_you_would_llike_to_give_vfc.vfc

## Notes: - Run the command while in the directory with all bam files i.e Bwa or Bowtie directory
##        - Make sure reference fasta is in the same directory
##        - make sure run_bcftools_variantcalling_queue.sh is executable. use code: chmod +x run_bcftools_variantcalling_queue.sh

#SBATCH --account=def-lukens
#SBATCH --time=0-06:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

#load module 
module load bcftools

echo "Starting variant calling"

# Perform variant calling
bcftools mpileup -a DP,AD -P ILLUMINA -f ./zebrafish_genome_GRCz11_GCA_000002035.fna *.sorted.bam | bcftools call -m --variants-only | bcftools view --include 'QUAL > 19'  --output-type v --output-file $1

echo "All done now!"