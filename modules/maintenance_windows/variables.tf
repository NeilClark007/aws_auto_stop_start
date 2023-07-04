variable "account_id" {
    # this imports the account_id information to this variable so it can be used by the module
    description = "Account ID of the AWS account where resources are deployed."
    type = string
}

variable "ssm_role_name" {
    # this imports the role name from the variable in the root variable.tf file
    description = "Role used by SSM Automation"
    type = string
 
}