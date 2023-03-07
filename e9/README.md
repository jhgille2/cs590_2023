# CS 590 Exercize 9  

To set up the environment, run this in the VCL.  
```bash
# Prepare bioinfo env
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda

# Activate bioinfo and install gdown and salmon (using mamba)
conda activate bioinfo
conda install -c bioconda -c conda-forge gdown salmon=1.10
```  

And then run this to run the pipeline.  
```r
renv::activate()
source("./packages.R")
tar_make()
```
