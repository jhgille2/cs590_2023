# Exercize 11

To run this in the vcl, run 

```
git clone https://github.com/jhgille2/cs590_2023.git
cd ./cs590_2023/e11

sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda

# Set up environment for the exercize
conda env create -f ./environment.yml 
conda activate e11
bash download_data.sh

# Open R console
R

# Load R packages (in R console)
source("./packages.R)

# Run the pipeline
tar_make()



```
