# CS 590 Exercize 9  

To set up the environment, run this in the VCL.  
```bash
# Download the repository
git clone https://github.com/jhgille2/cs590_2023.git

# Move into the e9 directory
cd ./cs590_2023/e9

# Prepare bioinfo env
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda

# Activate bioinfo and install gdown and salmon (using mamba)
conda activate bioinfo
conda install -c bioconda -c conda-forge gdown salmon=1.10

# Open R teminal
R
```  

And then run this.  
```r
# Restore project state from lockfile
renv::restore()

# Load packages
source("./packages.R")

# Run the targets pipeline
tar_make()
```
