# This module creates the required resource groups that will be used to identify resources that can be automatically stopped and started
resource "aws_resourcegroups_group" "default" {
  name = "default"
  description = "Resource Group to Identify Resources to be part of the default Auto Stop Start for 07_30-18_30"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::EC2::Instance"
  ],
  "TagFilters": [
    {
      "Key": "auto_stop_start",
      "Values": ["default"]
    }
  ]
}
JSON
  }
}

resource "aws_resourcegroups_group" "extended" {
  name = "extended"
  description = "Resource Group to Identify Resources to be part of the extended Auto Stop Start for 07_30-21_00"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::EC2::Instance"
  ],
  "TagFilters": [
    {
      "Key": "auto_stop_start",
      "Values": ["extended"]
    }
  ]
}
JSON
  }
}