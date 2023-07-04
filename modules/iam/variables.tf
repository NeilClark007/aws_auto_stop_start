variable "ssm_role_name" {
    # this variable is deliberately blank as it is pulled in from from the global variable.tf
    # this can be overidden here with a local entry if required
    description = "Role used by SSM Automation"
    type = string
 
}