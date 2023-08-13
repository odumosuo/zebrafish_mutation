#!/bin/sh

## Description: The script gets the alignment rate for the aligned fastq files
## Date: 05 May 2023

## How to run: ./run_get_alignment_statistics.sh name_to_give_file

## Notes: - need to run while in the directory that contains the bam files.
##        - The run_get_alignment_statistics.sh script also needs to be in the same directory


## load required module for samtool s /1.13
module load StdEnv/2020 gcc/9.3.0
## load module
module load samtools/1.13

## create file with appropriate header titles
echo -e "Sample \t Alignment_rate" >> $1 

### For each assembly run the following command to get the Id and the mapped percentage while in correct directory
## The code reads as follows. F or each file ending with sorted.bam in directory print the file name after removing everything after t he period, print a tab, perform flagst a t in samtools, grep the first line that shows mapped, and replace the pattern with the regrex pattern between t he brackets in the sed command , then append to a file that is appropriately named
for file in *sorted.bam; do echo -ne $file | sed 's/\..*//'; echo -ne "\t"; samtools flagstat $file | grep -m1 "mapped"| sed 's/.*(\([0-9]*\.[0-9]*\).*/\1/'; done >> $1