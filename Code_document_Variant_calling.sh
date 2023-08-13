## Request memory to perform variant calling.  
srun --pty --account="def-name_of_graham_host" -t 0-03:00:00 --mem=16000 /bin/bash

########### Using bcftools mpileup ################
#load module 
module load bcftools

# variant calling with bcftools mpileup. Run the following command for bwa alignments. Run the command while in the Bwa directory. The call includes only records with variants and a quality score of 20 or more. The output is output_file_name.vcf
bcftools mpileup -a DP,AD -P ILLUMINA -f ./zebrafish_genome_GRCz11_GCA_000002035.fna *.sorted.bam | bcftools call -m --variants-only | bcftools view --include 'QUAL > 19'  --output-type v --output-file output_file_name.vcf

#### Alternately with script. Script puts job in queue so will know it is done
sbatch run_bcftools_variantcalling_queue.sh name_you_would_llike_to_give_vfc.vfc

############# Using freebayes ##############
## Add readgroups and reindex bam file. 
# copy run_readgroups.sh to bwa directory. Run the command while in parent directory
scp ./run_readgroups_new.sh ./Bwa
scp ./run_readgroups_new.sh ./Bowtie

# Add readgroups and reindex bam file. Run the command while in the Bwa directory.
./run_readgroups_new.sh

# Perform variant calling with freebayes. Run command while in Bwa directory. 
sbatch run_freebayes_queue.sh


# Filter freebayes vcf to only include records with quality score of 20 or more. Run the command while in the Bwa directory. Output is freebayes_filtered.vcf
module load bcftools
vcftools --vcf unfiltered_freebayes.vcf --minQ 20 --recode --out freebayes_filtered.vcf

################# Get statistics ###################
# Load module
module load bcftools

# Get statistics and save to file. Output is vcf_stats. 
bcftools stats vcf_file.vcf | grep -v "^#" | grep "number of" | cut -d$'\t' -f3,4 > vcf_stats
