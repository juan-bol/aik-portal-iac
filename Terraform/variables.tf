variable "aik-ami-id" {
  description = "AMI ID used for apply to instance's AIK"
  default = "ami-0d6621c01e8c2de2c"

}

variable "vpc-cidr" {
  description = "VPC cidr to use for AIK VPC"
  default = "10.0.0.0/16"
}

variable "vpc-BRZ" {
  description = "Name VPC of AIK"
  default = "aik-vpc-BRZ"
}

variable "aws-availability-zones" {
  description = "availability zones to uses for AIK"
  default = "us-west-2a,us-west-2b"
}

variable "aik-instance-type" {
  description = "type of instance for use with instances of FRONT AND BACK"
  default = "t2.micro"
}

variable "aik-key-BRZ" {
  description = "Key pair name"
  default = "key-BRZ"
}
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = "string"
  default     = "3030"
}

variable "alb_BRZ" {
  description = "The name of the ALB"
  type        = "string"
  default     = "alb-aik-BRZ"
}

variable "instance_security_group_BRZ" {
  description = "The name of the security group for the EC2 Instances"
  type        = "string"
  default     = "instances_sg_BRZ"
}

variable "alb_security_group_BRZ" {
  description = "The name of the security group for the ALB"
  type        = "string"
  default     = "alb_sg_BRZ"
}

variable "aws_db_subnet_group_brz" {
  description = "Name of the database"
  type        = "string"
  default     = "db-brz"
}

variable "security_group_brz" {
  description = "Name of the database security group"
  type        = "string"
  default     = "sg_db_BRZ"
}