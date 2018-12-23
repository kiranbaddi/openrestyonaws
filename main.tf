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


resource "aws_security_group" "xyclient" {
    vpc_id = "${aws_vpc.xyclient.id}"

    ingress {
        cidr_blocks = [
            "${aws_vpc.xyclient.cidr_block}"
        ]
        from_port = 80
        to_port = 80
        protocol = "tcp" 
    }

    ingress {
        cidr_blocks = [
            "${aws_vpc.xyclient.cidr_block}"
        ]
        from_port = 8080
        to_port = 8080
        protocol = "tcp" 
    }
}

resource "aws_key_pair" "tfadmin" {
    key_name = "${var.key_name}"
    public_key = "${local.public_key}"
}

resource  "aws_instance" "webserver" {
    count = "${var.ec2_count}"
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.tfadmin.key_name}"
    vpc_security_group_ids = ["${aws_security_group.xyclient.id}"] subnet_id = "${aws_subnet.subnet1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags{
        name = "webserver-${count.index+1}"
    }
}





