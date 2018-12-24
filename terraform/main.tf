# Terraform to create ec2 instances on aws

# Configure the AWS Provider
provider "aws" {
    access_key = "${local.access_key}"
    secret_key = "${local.secret_key}"
    region     = "${var.region}"

}

#user data template.

data "template_file" "webserver" {
  template = "${file("${path.module}/templates/initscript.tpl")}"
}

#Security Group to allow traffic on ports 80 and 22 (ssh)

resource "aws_security_group" "xyclient_sg" {
    
    #Inbount Ports for port 80 to open the web
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
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
        cidr_blocks = ["0.0.0.0/0"]     
        from_port = 0
        to_port = 0
        protocol = -1

    }
    
    tags {
        name = "xyclient_sg"
    }
}

#Create ec2 instance within default VPC (assuming the account is only for one client)
resource  "aws_instance" "webserver" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.tfadmin.key_name}"
    associate_public_ip_address = true
    source_dest_check = false

    vpc_security_group_ids = ["${aws_security_group.xyclient_sg.id}"]

    user_data = "${data.template_file.webserver.rendered}"
    key_name  = "${var.aws_key_pair}"

    tags{
        name = "webserver"
        environment = "test"
    }
}



    







