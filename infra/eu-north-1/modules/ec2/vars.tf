variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.large"
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the EC2 instance"
  type        = string
  
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
  default     = "airbyte-key"
  
}

variable "vpc_security_group_id" {
  description = "The ID of the VPC security group to associate with the EC2 instance"
  type        = string
  
}

variable "instance_name" {
  description = "Name of the ec2 instance"
  type = string
  default = ""
}