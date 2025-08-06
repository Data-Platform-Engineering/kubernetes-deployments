#generate argocd admin user password
resource "random_password" "argo_admin_password" {
  length  = 10
  special = false
}

# Hash the password using built-in bcrypt() function
locals {
  hashed_password = bcrypt(random_password.argo_admin_password.result)
}

# store in aws secret manager
module "argo_admin_user_password" {
  source        = "./modules/secrets_manager"
  secrets_name  = "argocd/adminpassword"
  description   = "Argo CD login admin user password"

  secret_string = jsonencode({
    # Store the hashed password
    plain_password = random_password.argo_admin_password.result
    bcrypt_password    =  local.hashed_password
  })
}


# Generate random server.secretkey (must be base64 encoded for Argo CD)
resource "random_password" "argocd_server_secretkey" {
  length  = 32
  special = false
}

locals {
  base64_encoded_server_secretkey = base64encode(random_password.argocd_server_secretkey.result)
}

module "argo_server_secretkey" {
  source       = "./modules/secrets_manager"
  secrets_name = "argocd/serversecretkey"
  description  = "ArgoCD server.secretkey used to sign session tokens"

  secret_string = jsonencode({
    secretkey_base64 = local.base64_encoded_server_secretkey
  })
}






