# CS 590 Exercize 9  

To set up the environment, run this in the VCL.  
```bash
# Prepare bioinfo env
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda

# Install mamba for faster conda environment solving
curl micro.mamba.pm/install.sh | bash
source .bashrc
```  

And then run this to run the pipeline.  
```r
renv::activate()
source("./packages.R")
tar_make()
```
