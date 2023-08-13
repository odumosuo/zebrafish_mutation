#!/bin/sh

## Description: This script creates a directory for Bwa and Bowtie the copies all the fastq files as well as the reference genome and its indices to the files.  
## Date: 05 May 2023

## How to run: ./run_create_bwa_and_bowtie_folders.sh directory_with_indexed_referenceGenome directory_with_fastqfiles

## Notes: - need to be in parent directory that contains other directories
##        - make sure run_create_bwa_and_bowtie_folders.sh is executable. use code: chmod +x run_create_bwa_and_bowtie_folders.sh

# make directories for Bwa and Bowtie
mkdir Bwa
mkdir Bowtie

# Copy reference with indicies and fastq files to directories 
scp ./$1/* ./Bwa
scp ./$2/* ./Bwa

scp ./$1/* ./Bowtie
scp ./$2/* ./Bowtie
