variable "aws_region" {
  #update region as required
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "ssm_role_name" {
  # add the role name you wish to use for SSM automation
  description = "Role used by SSM Automation"
  type = string
  default = #"insert role name here"
 
}
