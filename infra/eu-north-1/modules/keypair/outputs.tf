# Output the values to access them from other modules
output "ssh_key_name" {
  value = aws_key_pair.argocd_ssh_key.key_name
}

output "private_key_pem" {
  value     = tls_private_key.argocd_key.private_key_pem
  sensitive = true # Mark as sensitive so it’s not printed in logs
}