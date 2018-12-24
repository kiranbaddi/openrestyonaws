#!/usr/bin/env bash
set -x
source /etc/lsb-release


sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y 
sudo apt-get install python-pip software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt install git -y

mkdir -p ~/installs
cd ~/installs

git clone https://github.com/kiranbaddi/openrestyonaws

#Run script to install ansible, docker
sudo bash install_tools.sh




