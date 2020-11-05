provider "aws" {
    region = "ca-central-1"
}
#create vpc
resource "aws_vpc" "CEN-fractal_vpc1" {
    cidr_block = var.vpc_cidr
    tags = {
        name = "CEN-fractal_vpc1"
    }
}

#create Internet gateway
resource "aws_internet_gateway" "CEN-fractal_vpc1_igw" {
    vpc_id = aws_vpc.CEN-fractal_vpc1.id
    tags = {
        name = "CEN-fractal_vpc1_igw"
    }
}

#create subnets
resource "aws_subnet" "CEN-fractal-subnet" {
    count                      = length(var.subnets_cidr)
    vpc_id                     = aws_vpc.CEN-fractal_vpc1.id
    cidr_block                 = element(var.subnets_cidr, count.index)
    availability_zone          = element(var.availability_zones, count.index)
    map_public_ip_on_launch    = true
    tags                       = {
        name = "CEN-fractal-subnet_${count.index +1}"
    }
}

resource "aws_route_table" "CEN-SUBN-PUB-rtb-1" {
    vpc_id = aws_vpc.CEN-fractal_vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id =  aws_internet_gateway.CEN-fractal_vpc1_igw.id
    }
    tags = {
        name = "CEN-SUBN-PUB-rtb-1"
    }
}


resource "aws_route_table_association" "rtb_subn_accociate" {
    count           = length(var.subnets_cidr)
    subnet_id       = element(aws_subnet.CEN-fractal-subnet.*.id, count.index)
    route_table_id  = aws_route_table.CEN-SUBN-PUB-rtb-1.id
}