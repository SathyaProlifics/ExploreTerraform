variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "Subnet configurations"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {}
}

variable "db_identifier" {
  description = "RDS database identifier"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = ""
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 0
}

variable "dbname" {
  description = "Database username"
  type        = string
  default     = ""
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = ""
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = ""
}

variable "bucket" {
  description = "S3 bucket name"
  type        = string
  default     = ""
}