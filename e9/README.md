# CS 590 Exercize 9  

To set up the environment, run this in the VCL.  
```bash
# Download the repository
git clone https://github.com/jhgille2/cs590_2023.git

# Move into the e9 directory
cd ./cs590_2023/e9

# Load conda
source load_conda

# Open R teminal
R
```  

And then run this in the R terminal.  
```r
# Restore project state from lockfile
renv::restore()

# Load packages
source("./packages.R")

# Run the targets pipeline
tar_make()
```
