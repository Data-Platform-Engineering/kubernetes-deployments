# Create a new Secrets Manager secret
resource "aws_secretsmanager_secret" "secrets_manager" {
  name        = var.secrets_name   # Name of the secret in AWS
  description = var.description    # Description for documentation
}

# Store a secret value (e.g., private key PEM) in the secret
resource "aws_secretsmanager_secret_version" "secrets_manager_version" {
  secret_id     = aws_secretsmanager_secret.secrets_manager.id  # Link to the secret
  secret_string = var.secret_string                              # The actual sensitive value
}


#use this for secrets manager.tf
# resource "aws_secretsmanager_secret" "argocd_ssh_key" {
#   name = "argocd-ssh-private-key"
#   description = "Private key for argocd EC2 access"
# }

# resource "aws_secretsmanager_secret_version" "argocd_ssh_key_version" {
#   secret_id     = aws_secretsmanager_secret.argocd_ssh_key.id
#   secret_string = tls_private_key.argocd_key.private_key_pem
# }


# -- How to retrieve and use this private key
# You don’t output the private key in Terraform outputs anymore.

# To use the private key, retrieve it securely from AWS Secrets Manager when you need to SSH or for automation, for example:

# aws secretsmanager get-secret-value --secret-id argocd-ssh-private-key --query SecretString --output text > argocd-key.pem
# chmod 400 argocd-key.pem

# Then SSH like usual:
# ssh -i argocd-key.pem ubuntu@<EC2_PUBLIC_IP>


# NEW LEARNING ON AWS SECRET MANAGER 
#If you run terraform apply after you have destroyed your resources, including this and you get this error;
# You can't create this secret because a secret with this name is already scheduled for deletion.

# You're seeing this error because AWS Secrets Manager won't let you create a new secret with the same name if that name is currently scheduled for deletion. This is a common issue when secrets are deleted but still in their scheduled deletion window (which by default is 7 to 30 days).

# It means:

# i. You previously deleted the secret (e.g., argocd-rds-creds, argocd-ec2-keypair).

# ii. But it's still in the "pending deletion" state.

# iii. AWS reserves the name until the deletion window expires.


# Solution Options
#Option 1: Restore the Secret
# If the secret is still within the deletion window, you can restore it using the AWS CLI:
 # aws secretsmanager restore-secret --secret-id argocd-rds-creds --region eu-north-1
#  aws secretsmanager restore-secret --secret-id argocd-ec2-keypair --region eu-north-1

# import it into terraform's current state

#  terraform import module.argocd_rds_password.aws_secretsmanager_secret.secrets_manager argocd-rds-creds
#  terraform import module.argocd_ec2_keypair_store.aws_secretsmanager_secret.secrets_manager argocd-ec2-keypair

# After restoring, Terraform will detect the existing secret and manage it.

# Option 2: Use a Different Name
#  Change the value of var.secrets_name in your Terraform config to something unique

# Option 3: Permanently Delete the Secret Immediately (not recommended for production)
#   If you're sure the secret is safe to permanently delete right away (e.g., in dev/test):
# aws secretsmanager delete-secret --secret-id argocd-rds-creds --force-delete-without-recovery --region eu-north-1
#  aws secretsmanager delete-secret --secret-id argocd-ec2-keypair --force-delete-without-recovery --region eu-north-1

# ⚠️ This cannot be undone.

