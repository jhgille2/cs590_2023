# Exercize 11

To run this workflow in the vcl, run 

```
git clone https://github.com/jhgille2/cs590_2023.git
cd ./cs590_2023/e11

# Download micromamba
curl micro.mamba.pm/install.sh | bash

# Set up conda
sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo/
source load_conda
conda activate bioinfo
conda config --add channels conda-forge

# Set up environment for the exercize
$HOME/.local/bin/micromamba install --file requirements.txt
bash download_data.sh

# Open R console
R
```

And then in the R console, run
```
# Load packages
source("./packages.R")

# Run pipeline
tar_make()
```

Then (within the R session), individual targets can be loaded by running `tar_load(target name)`. E.g. to look at the `cntsMax` target, you would run `tar_load(cntsMax)` to load it into the R environment, and then `cntsMax` to print the object.

The R session can be exited with `q()` and the output inspected/transferred as usual from the VCL.  

 The main outputs from the pipeline are in the `plots` directory. other important files are output to the main directory as the pipeline runs as defined in `_targets.R`
