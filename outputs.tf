# Outputs from the data block in main.tf are stored here

output "account_id" {
    value = data.aws_caller_identity.current.account_id  
}