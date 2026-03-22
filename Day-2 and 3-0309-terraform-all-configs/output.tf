output "instance_id" {
    value = aws_instance.name.id  
}
output "public_id" {
    value = aws_instance.name.public_ip
  
}