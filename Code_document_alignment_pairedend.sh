############### Setting up #############
# create a directory for fastq files and for reference genome fasta
mkdir directory_name

# Transfer all files to appropriate directory. Rename prefix of fastq files to start with an alphabet

# Make all files readable, writable and executable for user.
chmod -R 755 ./*

# unzip all files
gunzip ./*

################# Index reference fasta for bwa ###################
# Transfer run_bwabowtie2index_queuesub.sh to directory with reference genome 
mv run_bwabowtie2index_queuesub.sh Reference_genome_directory

# While in reference genome directory, use script to index reference genome for bwa. Command line argument (third word) is name of reference genome fasta
sbatch  run_bwabowtie2index_queuesub.sh  zebrafish_genome_GRCz11_GCA_000002035.fna

# check status of job
squeue -u graham_username
 


############### Perform alignment with bwa ##################
# Create folder for bwa and copy reference fasta with indices and fastq files into folders. Reference_genome_directory is name of directory with reference genome and indices. Raw_data_fastq_diectory is the name of directory with fastq files. Run code while in parent directory 
./run_create_bwa_and_bowtie_folders.sh Reference_genome_directory Raw_data_fastq_directory

### Run alignment with bwa
# copy run_pairedends_bwa_queuesub.sh and run_get_alignment_statistics.sh to Bwa directory
scp  run_pairedends_bwa_queuesub.sh Bwa
scp  run_get_alignment_statistics.sh Bwa

# Align fastq files with reference while in Bwa directory
for file in ./*R1*fastq; do sbatch run_pairedends_bwa_queuesub.sh $file; done

# check status of job
squeue -u graham_username


################## Get alignment statistics #################
# While in the directory that contains the Bam files (i.e in Bwa directory), run the command below. Command argument (third word) is the name you wish to name the output file
./run_get_alignment_statistics.sh name_to_give_file


################# Organization ##############
# rename aligned files (bam and bam.ai) to replace R1 with paired 
rename 's/R1/paired/' *bam*
