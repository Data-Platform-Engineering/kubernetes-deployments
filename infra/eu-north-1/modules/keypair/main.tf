resource "tls_private_key" "argocd_key" {
  algorithm = "ED25519"
}

# Creates an EC2 Key Pair using the algorithm 
resource "aws_key_pair" "argocd_ssh_key" {
  key_name   = var.ssh_key_name                        # Name of the key pair in AWS
  public_key = tls_private_key.argocd_key.public_key_openssh  # Public part of the key
}
