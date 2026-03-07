resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/20"
    tags = {
        Name = "sathya-vpc"
    }
  
}