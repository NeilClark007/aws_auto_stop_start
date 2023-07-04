
/* This module creates the IAM Role required for SSM to carry out automation tasks
*/
resource "aws_iam_role" "ssm_role_automation" {
  # this variable is pulled in from the local variables.tf file
  name = var.ssm_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ssm.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ssm_automation_attachment" {
  role       = aws_iam_role.ssm_role_automation.name
  # if you are using custom policies rather than AWS policies you will need to update this policy arn with your policy arn
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"

}