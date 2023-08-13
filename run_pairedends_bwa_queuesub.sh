#!/bin/sh

## Description: This script uses bwa to map reads (.fastq) to reference genome
## Date: 05 May 2023

## usage (for testing with just one sample of paired end reads):
## sbatch run_pairedends_bwa_queuesub sample_R1.fastq

## Notes: - all fastq files, reference genome (with indices), and run_pairedends_bwa_queuesub need to be in same directory
##        - change zebrafish_genome_GRCz11_GCA_000002035.fna on line 24 to name of reference genome fasta file. Include file extension
##        - make sure run_pairedends_bwa_queuesub is executable. use code: chmod +x run_pairedends_bwa_queuesub

#SBATCH --account=def-lukens
#SBATCH --time=0-02:00:00 ## days-hours:minutes:seconds
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4 # number of threads
#SBATCH --mem=16000 # requested memory (in MB)


module load bwa
module load samtools

fastq_1=$1
fastq_2=`echo $fastq_1 | sed 's/R1/R2/'`
basename=`echo $fastq_1 | sed 's/\.f.*\.gz.*//'`

echo "Starting alignment of $fastq_1 to reference genome"
bwa mem -t 16 zebrafish_genome_GRCz11_GCA_000002035.fna $fastq_1 $fastq_2 >  $basename.sam
echo "Converting sam to bam for $basename"
samtools view -b -S -o $basename.bam $basename.sam

echo "Sorting and indexing bam files for $basename"
samtools sort $basename.bam -o $basename.sorted.bam
samtools index $basename.sorted.bam

echo "Cleaning up the mess... just a minute!"
if [[ -s $basename.bam ]]
   then
       rm $basename.sam
       echo "removed $basename.sam"

else
    echo "$basename.sam is empty! Something's fishy..."
fi



if [[ -s $basename.bam ]]
   then
       rm $basename.bam
       echo "removed $basename.bam"

else
    echo "$basename.bam is empty! Something's fishy..."
fi
