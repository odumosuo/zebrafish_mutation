#!/bin/sh

## Description: This script will use the picard module to add read groups to .bam files. Rdequired for freebayes variant calling
## Date: 05 May 2023

## How to run: sbatch run_readgroups_new.sh

## Notes: - need to be in directory with bam files (i.e Bwa or Bowtie directory)

#SBATCH --account=def-lukens
#SBATCH --time=0-00:30:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)

# load modules
module load samtools
module load picard

i=1
for bam_file in ./*.bam; do
    basename=$(basename $bam_file .bam)
    echo "Adding read group information for $basename"
    java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
        I=$bam_file \
        O=$basename.bam.rg \
        RGID=${i} \
        RGLB=lib1 \
        RGPL=illumina \
        RGPU=unit1 \
        RGSM=$basename;
        samtools index $basename.bam.rg;
    i=$((i+1))
done