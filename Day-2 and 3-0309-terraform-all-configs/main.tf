resource "aws_instance" "name" {
    ami = var.instance-ami-id
    instance_type = "t2.micro"
    tags = {
        Name = var.instance-name
    }
}