# Create a directory for the local R: 
mkdir r-linux
cd r-linux

# Install the necessary build dependencies:
sudo sed -i.bak "/^#.*deb-src.*universe$/s/^# //g" /etc/apt/sources.list
sudo apt-get update

# Define the R version you want to install 
export R_VERSION=3.6.2

# Download and extract the version of R that you want to install:
curl -O https://cran.rstudio.com/src/base/R-3/R-${R_VERSION}.tar.gz
tar -xzvf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}

# Build and install R by running the following commands:
./configure \
--prefix=/opt/R/${R_VERSION} \
--enable-memory-profiling \
--enable-R-shlib \
--with-blas \
--with-lapack

make
sudo make install

# Test that R was successfully installed by running:
/opt/R/${R_VERSION}/bin/R --version
