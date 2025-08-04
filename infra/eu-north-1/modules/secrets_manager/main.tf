# Create a new Secrets Manager secret
resource "aws_secretsmanager_secret" "secrets_manager" {
  name        = var.secrets_name   
  description = var.description    
}

# Store a secret value (e.g., private key PEM) in the secret
resource "aws_secretsmanager_secret_version" "secrets_manager_version" {
  secret_id     = aws_secretsmanager_secret.secrets_manager.id  
  secret_string = var.secret_string                              
}


