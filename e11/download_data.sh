# Make the data directory
mkdir ./data
cd ./data

# Download the exercize data
gdown 19O0s0OZSGEemCUCI5UkKI9wSInYfEr-q
tar -xzf Epigenetic_Data.tar.gz
rm Epigenetic_Data.tar.gz

# Doanload maize gff file
wget https://ftp.maizegdb.org/MaizeGDB/FTP/B73_RefGen_v2/ZmB73_5a.59_WGS.gff3.gz

# unzip this file
gunzip ./ZmB73_5a.59_WGS.gff3.gz
