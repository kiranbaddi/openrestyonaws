variable "region" {
    default = "us-west-2"
}

variable "aws_access_key" {
    type = "string"
    description = "Access Key of the user"
}

variable "secret_key" {
    type = "string"
    description = "Access Key of the user"
}

variable "public_key" {
    type = "string"
    description = "Public key to authenicate"
}


locals {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.secret_key}"
    public_key = "${var.public_key}"
}


variable "vpc_cidr" {
    default = "192.168.0.0/16"
}

variable "subnet_cidr" {
    default = "192.168.10.0/24"
}

variable "ec2_count" {
    description = "The number of ec2 instances."
    default = 3
} 

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

variable "key_path" {
    description = "Key path for SSHing into EC2"
    default  = "./ssh/tfprovisioner.pem"
}

variable "key_name" {
    description = "Key name for SSHing into EC2"
    default = "tfadmin"
}