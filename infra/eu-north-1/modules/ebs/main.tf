# Create an EBS volume
resource "aws_ebs_volume" "argocd_data_volume" {
  availability_zone = var.availability_zone        # E.g., "eu-north-1a"
  size              = var.ebs_volume_size                          # Size in GB
  type              = "gp3"                         # Recommended for performance
  encrypted         = true                          # Encrypt the volume

  tags = {
    Name = var.ebs_volume_name
  }
}


