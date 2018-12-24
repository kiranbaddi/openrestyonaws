#!/bin/bash
sudo apt-get update
# Install dependencies
sudo apt-get install build-essential dh-make devscripts lintian zlib -y
sudo apt-get install libpcre3-dev libssl-dev perl make build-essential curl -y
mkdir openresty
cd openresty
wget https://openresty.org/download/openresty-1.13.6.2.tar.gz
cd  openresty-1.13.6.2

dh_make -f ../openresty-1.13.6.2.tar.gz --s -y

echo "override_dh_auto_configure:" >> debian/rules
echo -e "\t ./configure -j2" >> debian/rules

echo "override_dh_usrlocal:" >> debian/rules

debuild -us -uc

sudo mkdir /openresty-deb-pkg
sudo cp ../openresty_1.13.6.2-1_amd64.deb /openresty-deb-pkg/
sudo cp ../openresty_1.13.6.2-1_amd64.deb ~/openresty-task/docker/
sudo rm -rf ../../openresty
