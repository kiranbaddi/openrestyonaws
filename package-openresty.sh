# Script to create Debian package out of the openresty source code

#!/bin/bash
# update repos and install extensions required to create package 
sudo apt-get update
sudo apt-get install build-essential dh-make devscripts lintian -y
sudo apt-get install libpcre3-dev libssl-dev perl make build-essential curl -y

# Create folder to store teh package
mkdir openresty
cd openresty
# Check if Openresty tar ball is downloaded, if not download from source
if [ ! -f openresty-1.13.6.2.tar.gz ]
then
wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
tar zxvf openresty-1.13.6.2.tar.gz
fi
cd  openresty-1.13.6.2

DEBEMAIL="kiran_baddi@hotmail.com"
DEBFULLNAME="Kiran Baddi"
export DEBEMAIL DEBFULLNAME

dh_make -f ../openresty-1.13.6.2.tar.gz --s -y

echo "override_dh_auto_configure:" >> debian/rules
echo -e "\t ./configure -j2" >> debian/rules

echo "override_dh_usrlocal:" >> debian/rules

debuild -us -uc

sudo mkdir /openresty-deb-pkg
sudo cp ../openresty_1.13.6.2-1_amd64.deb /openresty-deb-pkg/
sudo cp ../openresty_1.13.6.2-1_amd64.deb ~/openresty-task/docker/
sudo rm -rf ../../openresty