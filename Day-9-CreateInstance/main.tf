resource "aws_instance" "sathya-ec2-instance" {
    ami = var.instance-ami-id
    instance_type = "t2.micro"
    tags = {
        Name = var.instance-name
    }
}