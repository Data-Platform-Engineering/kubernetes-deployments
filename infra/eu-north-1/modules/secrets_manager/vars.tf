variable "secrets_name" {
    description = "The name of the secret in AWS Secrets Manager"
    type        = string
}


variable "description" {
    description = "Description of the secret"
    type = string
  
}

# variable "secrets_id" {
#     description = "The ID of the secret in AWS Secrets Manager"
#     type        = string
  
# }

variable "secret_string" {
    description = "The secret string to store in AWS Secrets Manager"
    type        = string
    default     = ""
  
}