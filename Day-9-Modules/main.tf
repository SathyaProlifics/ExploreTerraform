module "dev" {
    source = "../Day-9-CreateInstance"
    instance-name = "sathya-ec2-server-dev"
    instance-ami-id = "ami-02dfbd4ff395f2a1b"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"

  subnet_id     = "subnet-0e413c1d9855ae45b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-12213213"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}