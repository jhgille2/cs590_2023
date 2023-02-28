# Install gdown
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda
conda activate bioinfo

# Install gdown, vcftools, and update freebayes
conda install -c conda-forge gdown vcftools freebayes==1.3.2

# Download dataset
gdown 1XZ0p_CzCgq_B_khJr5x6rnS5c4zYbJF2

# Uncompress RADseq.tgz
tar -xzf variant_calling_exercise.tar.gz

# Make a file that has the paths to all the .bam files
ls -d "$PWD"/variant_calling_exercise/bamfiles_withQ/* > all_bam_files

# Freebayes
freebayes -f ./variant_calling_exercise/LG2.fa --use-best-n-alleles 4 -L all_bam_files > out.vcf

# Missingness by individual
vcftools --vcf out.vcf --out missing_individual --missing-indv

# Missingness by site
vcftools --vcf out.vcf --out missing_individual --missing-site

# Site quality
vcftools --vcf out.vcf --out quality_site --site-quality

# Depth by individual
vcftools --vcf out.vcf --out depth_individual --depth

# Depth by site
vcftools --vcf out.vcf --out depth_site --site-depth

# Allele frequency
vcftools --vcf out.vcf --out allele_freq --freq
