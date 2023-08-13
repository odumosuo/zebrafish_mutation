########### Using snpeff software ############
# download and install snpeff while in home directory of local computer
curl -v -L 'https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip' > snpEff_latest_core.zip
unzip snpEff_latest_core.zip

# move to snpEff directory
cd snpEff/

# get list of available zebrafish databases
java -jar snpEff.jar databases | grep "Danio"

# Download needed database
java -jar snpEff.jar download -v GRCz11.99

### Adjust names of chromosomes in vcf file to fit names of chromosomes in database
# Check names of chromosomes in database. Perform while in snpEff directory. Output is annotated_bwa_bcftools.html and annotated_bwa_bcftools.ann.vcf. 
java -Xmx8g -jar snpEff.jar -v -stats annotated_bwa_bcftools.html GRCz11.105 ../input_vcf_file.vcf > ../annotated_bwa_bcftools.ann.vcf

# check names of chromosome in vcf file. Perform while in snpEff directory
cat ../input_vcf_file.vcf | grep -v "^#" | cut -f 1 | uniq

# change names of chromosomes in vcf to match database. Create a new file called input_updated_vcf. Only updated chromosomes here not other contigs. Perform while in snpEff directory

cat ../input_vcf_file.vcf | sed "s/^NC_007112.7/1/"| sed "s/^NC_007113.7/2/" | sed "s/^NC_007114.7/3/"| sed "s/^NC_007115.7/4/" | sed "s/^NC_007116.7/5/" | sed "s/^NC_007117.7/6/" | sed "s/^NC_007118.7/7/" | sed "s/^NC_007119.7/8/" | sed "s/^NC_007120.7/9/" | sed "s/^NC_007121.7/10/" | sed "s/^NC_007122.7/11/" | sed "s/^NC_007123.7/12/" | sed "s/^NC_007124.7/13/" | sed "s/^NC_007125.7/14/" | sed "s/^NC_007126.7/15/" | sed "s/^NC_007127.7/16/" | sed "s/^NC_007128.7/17/" | sed "s/^NC_007129.7/18/" | sed "s/^NC_007130.7/19/" | sed "s/^NC_007131.7/20/" | sed "s/^NC_007132.7/21/" | sed "s/^NC_007133.7/22/" | sed "s/^NC_007134.7/23/" | sed "s/^NC_007135.7/24/" | sed "s/^NC_007136.7/25/"  > ../ input_updated_vcf.vcf

# perform variant annotation. Perform while in snpEff directory. Output is annotated_bwa_bcftools.html and annotated_bwa_bcftools.ann.vcf. 
java -Xmx8g -jar snpEff.jar -v -stats ../annotated_bwa_bcftools.html GRCz11.105 ../ input_vcf_file.vcf > ../annotated_bwa_bcftools.ann.vcf
