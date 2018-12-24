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
6. Source Control: git

Steps:
1. Spin up an ubuntu:bionic[i] ec2 instance within default VPN 
2. aws userdata (Start up script) has the following steps:
      > install ansible
      > install docker
      > install git
      > clone the git repository  
3. SSH into ec2 instance with key-pair mentioned in the terraform config file
4. Run 
        # bash ./package_openresty.sh
5. Create Docker image
        docker build -t openresty .
6. Start openresty with the playbook 
        ansible-playbook start_openresty.yml
7. Install nagios
        ansible-playbook openresty-stop.yml




Assumptions:
        The project is made wiht the following assumpitoons

        1. AWS account is a dedicated to one client, hence no VPCs.
        2. Only Webserver suffices for the purpose. In Real time we need to create more than instance and load balance (with an elastic IP)


Notes:
        i Ubuntu was chosen because it comes with most librarires such as gcc and tools like git and vim pre-installed and package management is much easier



