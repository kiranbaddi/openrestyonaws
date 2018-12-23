ProjectName: openrestyonaws
Objective : Run a Dockerized openresty application on aws



Pre-Requisites:

1. AWS Account (Free-tier for this case study)

Software Used:
1. Provisioning :  Terraform (awscli should be installed along with Terraform)
2. Configuration:  Ansible 
3. Containers:     Docker   
4. WebServer:      Openresty (packaged as .deb from source-coede) 
5. Monitoring:     Nagios

Steps:
1. Spin up an ubuntu:bionic[i] ec2 instance within a (non-default) VPN and assign an elastic IP[ii] 
2. aws userdata (Start up script) has the following steps:
        I.  Clone the repository 
        II. Package openresty code as .deb package
        III. Build docker image with the Dockerfile
        IV.  Run Docker container with the openresty image
        
3. Start 
    
2. SSH into ec2 instance with key-pair mentioned in the terraform config file



