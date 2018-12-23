# Terraform to create ec2 instances on aws

# Configure the AWS Provider
provider "aws" {
    access_key = "${local.access_key}"
    secret_key = "${local.secret_key}"
    region     = "${var.region}"

}

resource "aws_vpc" "xyclient" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    tags {
        name = "xyclient"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = "${aws_vpc.xyclient.id}"
    cidr_block = "${var.subnet_cidr}"

    tags {
        name = "Subnet1"
    }
}

#Security Group to allow traffic on ports 80 and 22 (ssh)

resource "aws_security_group" "xyclient" {
    vpc_id = "${aws_vpc.xyclient.id}"
    #Inbount Ports for port 80 to open the web
    ingress {
        cidr_blocks = ["0.0.0.0/0"]        ]
        from_port = 80
        to_port = 80
        protocol = "tcp" 
    }
    # Inbound port for ssh
    ingress {
        cidr_blocks = ["0.0.0.0/0"] 
        from_port = 22
        to_port = 22
        protocol = "tcp" 
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1

    }
}

resource "aws_key_pair" "tfadmin" {
    key_name = "${var.key_name}"
    public_key = "${local.public_key}"
}



#Create ec2 instance within the xyclient VPC and under subnet1
resource  "aws_instance" "webserver" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.tfadmin.key_name}"
    vpc_security_group_ids = ["${aws_security_group.xyclient.id}"] subnet_id = "${aws_subnet.subnet1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags{
        name = "webserver"
        environment = "test"
    }

#Create Elastic IP for the instance to be publicly available 
resource "aws_eip" "xyclient_web" {
  instance = "${aws_instance.webserver.id}"
  vpc      = true
}
    

}





