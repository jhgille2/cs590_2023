# Script for the commands used in week 5 of CS590

# Install gdown, activate bioconda
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda
conda activate bioinfo
conda install -c conda-forge gdown

# # Download the sequencing data
gdown 1Vu7N3v3WDCWZLrovgAUadXluUDeqwV4T

# # Uncompress the assembly archive
tar -xzf YeastAssembly.tar.gz

# Concatenate the paired reads into one single-end file
cat ./YeastAssembly/yeastCh15.read1.fq ./YeastAssembly/yeastCh15.read2.fq > yeastCh15.readsAll.fq

# fastqc
fastqc ./YeastAssembly/yeastCh15.read1.fq ./YeastAssembly/yeastCh15.read2.fq

# Make a directory to do the assembly in 
mkdir ./masurca_assembly
cd ./masurca_assembly

# # Download the config file for this exercize from my github
# # (I already edited the required fields)
wget https://raw.githubusercontent.com/jhgille2/cs590_2023/main/exercize_5_masurca_config.txt

# Get the assemble.sh script
/usr/local/MaSuRCA-4.0.1/bin/masurca exercize_5_masurca_config.txt

# Start the assembly
nohup ./assemble.sh &

BACK_PID=$!
while kill -0 $BACK_PID ; do
    echo "Asssembler be assemblin..."
    sleep 30
    # You can add a timeout here if you want
done

# Visualize assembly against reference genome with Mummer
# 0. Install gnuplot
sudo apt install gnuplot

# 1. Make out.delta file
nucmer $HOME/YeastAssembly/S288C_reference_Chr15.fa ./CA/final.genome.scf.fasta

# 2. Run mummerplot to make the plot from the out.delta file
mummerplot -l -p MyAlignment --png --large out.delta


##########################################################################################################
# PART 2: re-run with paired end reads

# Go back to the starting directory
cd $HOME

# make a new directory for the second alignment
mkdir masurca_assembly_paired

# Go into this directory
cd ./masurca_assembly_paired

# Download a config file that I already prepared
wget https://raw.githubusercontent.com/jhgille2/cs590_2023/main/exercize_5_masurca_pairedend_config.txt

# Get the assemble.sh script
/usr/local/MaSuRCA-4.0.1/bin/masurca exercize_5_masurca_pairedend_config.txt

# Run the assembly
nohup ./assemble.sh &
BACK_PID=$!
while kill -0 $BACK_PID ; do
    echo "Asssembler be assemblin..."
    sleep 30
    # You can add a timeout here if you want
done

# Visualize assembly against reference genome with Mummer
# 1. Make out.delta file
nucmer $HOME/YeastAssembly/S288C_reference_Chr15.fa ./CA/final.genome.scf.fasta

# 2. Run mummerplot to make the plot from the out.delta file
mummerplot -l -p MyAlignment --png --large out.delta
