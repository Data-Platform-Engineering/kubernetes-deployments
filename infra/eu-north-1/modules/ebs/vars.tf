variable "availability_zone" {
  description = "The availability zone where the EBS volume will be created"
  type = string
}

variable "ebs_volume_size" {
  description = "size in GB of the EBS volume"
  type = number
  default = 50
}

variable "ebs_volume_name" {
  description = "The name of the EBS volume"
  type        = string
  default     = "AirbyteDataVolume"
  
}
