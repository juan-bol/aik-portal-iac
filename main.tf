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

resource "aws_instance" "aik-portal" {
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
    set -euf -o pipefail
    exec 1> >(logger -s -t $(basename $0)) 2>&1

    sudo yum install -y git
    sudo git clone https://github.com/icesi-ops/aik-portal.git /srv/App
    sudo chmod 700 /srv/App
    
    # install node
    sudo yum install -y gcc-c++ make
    curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
    sudo yum install -y nodejs

    cd /srv/App/aik-portal/aik-app-ui
    sudo npm install
    node server.js        

    EOF
    
}