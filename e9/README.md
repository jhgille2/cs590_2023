# CS 590 Exercize 9  

To set up the environment, run this in the VCL.  
```bash
# Download the repository
git clone https://github.com/jhgille2/cs590_2023.git

# Prepare bioinfo env
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda

# Activate bioinfo and install gdown and salmon (using mamba)
conda activate bioinfo
conda install -c bioconda -c conda-forge gdown salmon=1.10
```  

And then run this.  
```r
# activate the renv workspace
renv::activate()

# Load packages
source("./packages.R")

# Run the targets pipeline
tar_make()
```
