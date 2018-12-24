# Script to install docker and ansible in ubutnu

#!/bin/bash

###	This file should be run in SUDO mode

### The script file needs to be executable, i.e.
#	chmod +x script.sh

#	Update package index
sudo apt-get update -y

sudo apt-get install python-pip software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y
sudo apt-get install git -y

#	Install tools
sudo apt-get install -y \
	    apt-transport-https \
	        ca-certificates \
		    curl \
		        software-properties-common

#	Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#	Setup stable repo
sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	      $(lsb_release -cs) \
	         stable"

#	Update package index (again)
sudo apt-get update

#	Install latest version of Docker CE
sudo apt-get install docker-ce -y

