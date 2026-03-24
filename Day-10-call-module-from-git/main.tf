
module "rds" {
    source = "github.com/SathyaProlifics/ExploreTerraform/Day-10-Custom_RDS_Module"
    vpc_cidr = var.vpc_cidr

subnets = var.subnets

db_identifier         = var.db_identifier
db_name               = var.db_name
db_instance_class     = var.db_instance_class
db_allocated_storage  = var.db_allocated_storage
db_username           = var.dbname

backup_window      = var.backup_window
maintenance_window = var.maintenance_window
bucket             = var.bucket

  
}