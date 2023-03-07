setup_env <- function(){

    system("sudo chown -R $USER:mlocate /shared/conda/envs/bioinfo")
    system("source load_conda")
    system("conda activate bioinfo")
    system("conda install -c bioconda -c conda-forge gdown salmon=1.10")

}