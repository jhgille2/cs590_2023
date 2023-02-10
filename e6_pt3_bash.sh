#!/bin/bash
# Get the Module3 tar archive from google drive and unpack it in your home directory

tar -xzf Module3.tar.gz

# Change into the Module3 directory, make all scripts in the scripts directory executable
cd Module3
chmod u+x scripts/*

 # *** Before starting this exercise, you should have completed the following steps! ***
 # Create a virtual environment with Python v2.7 (default in the VCL instance is v3.6)
 # conda create --name py2 python=2.7
 # Activate the virtual environment so Python v2.7 scripts will run without errors
conda activate py2


# Create a subset of the human reference genome with chromosomes 3, 6, 9 and 12
# to reduce the amount of memory required for the analyses to be done as part of the exercise.
# After producing the subset, delete all files related to the full human genome to free
# up disk space for the rest of the exercise.

bioawk -cfastx '{if($name==3 || $name==6 || $name==9 || $name==12) {print ">"$name"\n"$seq}}' human_g1k_v37.fasta | fold | gzip > chr36912.fa.gz
rm human_g1k_v37*

# Index the reference genome subset, then align the "normal" and "tumour" reads to it.
bwa index -p subset chr36912.fa.gz
bwa mem -t8 -p subset reads.tumour.fastq | samtools sort -o tumour.bam -
bwa mem -t8 -p subset reads.normal.fastq | samtools sort -o normal.bam -
# Index the sorted bam files
samtools index tumour.bam
samtools index normal.bam

# Find improperly-paired or 'discordant' read pairs
samtools view -b -F 1294 tumour.bam > tumour.discordants.bam
samtools view -b -F 1294 normal.bam > normal.discordants.bam

# Find split reads
samtools view -h tumour.bam | scripts/extractSplitReads_BwaMem -i stdin | samtools view -b - > tumour.splitters.bam
samtools view -h normal.bam | scripts/extractSplitReads_BwaMem -i stdin | samtools view -b - > normal.splitters.bam

# Make histogram of insert size distribution
samtools view tumour.bam | tail -n+10000 | scripts/pairend_distro.py -r 101 -X 4 -N 10000 -o sample.lib1.histo
samtools view normal.bam | tail -n+10000 | scripts/pairend_distro.py -r 101 -X 4 -N 10000 -o normal.lib1.histo

# Edit /Module3/scripts/lumpyexpress.config so line 4 is LUMPY_HOME=/usr/local/lumpy-sv
sed -i 's%LUMPY_HOME=~%LUMPY_HOME=/usr/local%' scripts/lumpyexpress.config

# Invoke lumpy program with the files created above as input - process tumour sample first
lumpy \
    -mw 4 \
    -tt 0 \
    -pe id:tumour,bam_file:tumour.discordants.bam,histo_file:sample.lib1.histo,mean:330,stdev:110,read_length:101,min_non_overlap:101,discordant_z:5,back_distance:10,weight:1,min_mapping_threshold:20 \
    -sr id:tumour,bam_file:tumour.splitters.bam,back_distance:10,weight:1,min_mapping_threshold:20 \
    > tumour.vcf
# Repeat with normal sample
lumpy \
    -mw 4 \
    -tt 0 \
    -pe id:normal,bam_file:normal.discordants.bam,histo_file:normal.lib1.histo,mean:350,stdev:125,read_length:101,min_non_overlap:101,discordant_z:5,back_distance:10,weight:1,min_mapping_threshold:20 \
    -sr id:normal,bam_file:normal.splitters.bam,back_distance:10,weight:1,min_mapping_threshold:20 \
    > normal.vcf
