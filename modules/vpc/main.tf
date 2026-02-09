resource "aws_vpc" "this" {
    cidr_block           = var.cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
      Name = var.name
    } 
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
      Name = "${var.name}-igw"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.azns[count.index]

    tags = {
      Name = "${var.name}-public-${count.index}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.azns[count.index]

    tags = {
      Name = "${var.name}-private-${count.index}"
    }
}

resource "aws_route" "public_internet_access" {
    route_table_id         = aws_route_table.public.id
    gateway_id             = aws_internet_gateway.this.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnets)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}