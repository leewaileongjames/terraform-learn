provider "aws" {
    region = "us-east-2"
}

variable "cidr_blocks" {
    description = "cidr blocks and name tags for vpc and subnet"
    default = [
        {cidr_block = "10.0.0.0/16", name = "nana-dev-vpc"},
        {cidr_block = "10.0.10.0/24", name = "nana-dev-subnet"}
    ]
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

variable avail_zone {} // Set using the TF_VAR_avail_zone env variable

resource "aws_vpc" "development-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet.id
}
