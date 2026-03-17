resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod-vpc"
  }         
  
}
#public subnet
resource "aws_subnet" "prod" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "prod-subnet1"
  } 
}
#private subnet
resource "aws_subnet" "prod2" {
    vpc_id     = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name = "prod-subnet2"
    }    
  
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod-igw"
  } 
}

resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }
  tags = {
    Name = "prod-rt"
  }     
}

resource "aws_route_table_association" "prod" {
  subnet_id      = aws_subnet.prod.id
  route_table_id = aws_route_table.prod.id
}

resource "aws_security_group" "prod" {
  name        = "prod-sg"
  description = "Security group for prod VPC"
  vpc_id      = aws_vpc.prod.id 
  #inboud rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   #inboud rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   #outboud rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Elastic IP for NAT Gateway
resource "aws_eip" "prod2" {
  domain = "vpc"
  tags = {
    Name = "prod-nat-eip"
  }
}
resource "aws_nat_gateway" "prod" {
  allocation_id = aws_eip.prod2.id
  subnet_id     = aws_subnet.prod.id  # NAT GW should be in PUBLIC subnet
  tags = {
    Name = "prod-nat-gateway"
  }
}
#Elastic IP for NAT Gateway
resource "aws_route_table" "prod_private" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod.id
  }
  tags = {
    Name = "prod-private-rt"
  }
}
#associate private subnet with private route table
resource "aws_route_table_association" "prod_private" {
  subnet_id      = aws_subnet.prod2.id
  route_table_id = aws_route_table.prod_private.id
}
#Ec2 instance in public subnet
resource "aws_instance" "public" {
  ami           = "ami-03caad32a158f72db"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.prod.id]
}
resource "aws_instance" "private" {
  ami           = "ami-03caad32a158f72db"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod2.id
  vpc_security_group_ids = [aws_security_group.prod.id]
}

resource "aws_rds" "name" {
  
}