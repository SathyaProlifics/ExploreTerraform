variable "instance-name" {
    default = ""
    type = string
    description = "Name of the EC2 instance"
}
variable "instance-ami-id" {
    default = ""
    type = string
    description = "AMI ID for the EC2 instance"
}
variable "instance-type" {
    default = ""
    type = string
    description = "Instance type for the EC2 instance"
}