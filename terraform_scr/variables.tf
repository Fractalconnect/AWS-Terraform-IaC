#infrastructure build variable definintions

variable "aws_region" {
    default = "ca-central-1"
}

variable "key_name" {
    default = "CAN-KP1"
}

variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "subnets_cidr" {
    type     = list(string)
    default  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24"]
}

variable "availability_zones" {
    type     = list(string)
    default  = ["ca-central-1a", "ca-central-1b", "ca-central-1d"]
}
# Ubuntu free AMI
variable "kubernetes_ami" {
    default = "ami-0edab43b6fa892279"
}

variable "master_instance_type" {
    default = "t2.micro"
}

variable "worker_instance_type" {
    default = "t2.micro"
}