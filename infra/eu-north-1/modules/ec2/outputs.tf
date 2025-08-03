output "ec2_public_ip" {
  value = aws_instance.argocd.public_ip
}

output "instance_id" {
  value = aws_instance.argocd.id
}