resource "aws_instance" "argocd" {
  ami           = "ami-042b4708b1d05f512" # Ubuntu 22.04 - ami-042b4708b1d05f512
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.ssh_key_name # Replace this
  associate_public_ip_address = true
  vpc_security_group_ids = [var.vpc_security_group_id]

  user_data = file("./user_data/bootstrap_server.sh") #bootstrap script
  
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
  tags = {
    Name = var.instance_name
  }
}

