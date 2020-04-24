provider "aws"{
    region = "us-east-1"
}

resource "aws_vpc" "aik-vpc" {
    cidr_block = "10.0.0.0/16"
    tags={
        Name = "juanbol"
    }
}

resource "aws_internet_gateway" "aik-igw" {
    vpc_id = "${aws_vpc.aik-vpc.id}"
}

resource "aws_subnet" "public-sub" {
    vpc_id     = "${aws_vpc.aik-vpc.id}"
    cidr_block = "${cidrsubnet("10.0.0.0/16", 8, 1)}"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true // a cada instancia nueva que de despliegue se le asigna una ip pública

    tags = {
        Name = "public-juanbol"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.aik-vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.aik-igw.id}"
    }
}


resource "aws_route_table_association" "rtb-assoc-sub" {
    subnet_id = "${aws_subnet.public-sub.id}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_security_group" "sg-instance" {
    vpc_id = "${aws_vpc.aik-vpc.id}"
    ingress {
        from_port = 3030
        to_port = 3030
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "aik-portal-front" {
    ami = "ami-0fc61db8544a617ed"
    instance_type = "t2.micro"
    key_name = "developer"
    vpc_security_group_ids = ["${aws_security_group.sg-instance.id}"]
    subnet_id = "${aws_subnet.public-sub.id}"
    tags = {
        Name = "INs-juanbol"
    }
    user_data = <<-EOF

        #!/bin/bash
        sudo yum update -y
        sudo yum install -y git 
        #Clone salt repo
        git clone https://github.com/juan-bol/aik-portal-iac.git /srv/Configuration_management

        #Install Salstack
        sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm
        sudo yum clean expire-cache;sudo yum -y install salt-minion; chkconfig salt-minion off

        #Put custom minion config in place (for enabling masterless mode)
        sudo cp -r /srv/Configuration_management/SaltStack/minion.d /etc/salt/
        echo -e 'grains:\n roles:\n  - frontend' > /etc/salt/minion.d/grains.conf

        ## Trigger a full Salt run
        sudo salt-call state.apply

    EOF
    
}