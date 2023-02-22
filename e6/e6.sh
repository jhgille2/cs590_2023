# Download gdown, activate bioinfo
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda
conda activate bioinfo
conda install -c conda-forge gdown


# Download exercize data
gdown 1kq3yv_-dVgg76IikeB0GvzM7eelFrOzk

# Unpack the reference data
tar -xzf SV_Exercise.tar.gz

# Index the reference
bwa index -p B73 ./SV_Exercise/Zm-B73-Ref-CHR5-175Mb-End.fa

# Map reads to the reference, sort and output a bam
bwa mem -t 16 B73 ./SV_Exercise/CML52.read1.fq ./SV_Exercise/CML52.read2.fq | samtools sort -o CML52.bam

# Look at some mapping stats
samtools flagstat CML52.bam

# Download lumpy
git clone --recursive https://github.com/arq5x/lumpy-sv.git
cd lumpy-sv
make
sudo cp bin/* /usr/local/bin/

# Go home
cd $HOME

# Get discordant reads 
samtools view -b -F 1294 CML52.bam > CML52.discordants.bam

# Get split reads
samtools view -h CML52.bam | ./lumpy-sv/scripts/extractSplitReads_BwaMem -i stdin | samtools view -Sb - > CML52.splitters.bam

# Summarise fragment lengths
samtools view CML52.bam | tail -n+100000 | ./lumpy-sv/scripts/pairend_distro.py -r 101 -X 4 -N 10000 -o sample.histo

# Run lumpy
lumpy -mw 4 -tt 0 -pe id:sample,bam_file:CML52.discordants.bam,histo_file:sample.histo,mean:496.6609033931273,stdev:54.63947689305526,read_length:150,min_non_overlap:150,discordant_z:5,back_distance:20,weight:1,min_mapping_threshold:20 -sr id:sample,bam_file:CML52.splitters.bam,back_distance:20,weight:1,min_mapping_threshold:20 > sample.vcf

# Check if lumpy found the inversion
vcftools --vcf sample.vcf --out sample.filtered --chr chr5 --from-bp 5000000 --to-bp 10000000 --recode --recode-INFO-all

# Get alignment image
gdown 1rdSi3iOlzwjVFzthpw7bJK1Nwtgbb2wa
