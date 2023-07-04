#  The three resource blocks below create the default maintenance windows. customise your times as required
resource "aws_ssm_maintenance_window" "auto_start_0730" {
  name     = "auto_start_0730"
  description = "Window to automatically start EC2 Instances at 07_30"
  schedule = "cron(30 07 ? * MON-FRI *)"
  duration = 4
  cutoff   = 0
  allow_unassociated_targets = false
  enabled = true
  schedule_timezone = "Europe/London"
}

resource "aws_ssm_maintenance_window" "auto_stop_1830" {
  name     = "auto_stop_1830"
  description = "Window to automatically stop EC2 Instances at 18_30"
  schedule = "cron(30 18 ? * MON-FRI *)"
  duration = 4
  cutoff   = 0
  allow_unassociated_targets = false
  enabled = true
  schedule_timezone = "Europe/London"
}

resource "aws_ssm_maintenance_window" "auto_stop_2100" {
  name     = "auto_stop_2100"
  description = "Window to automatically stop EC2 Instances at 21_00"
  schedule = "cron(00 21 ? * MON-FRI *)"
  duration = 4
  cutoff   = 0
  allow_unassociated_targets = false
  enabled = true
  schedule_timezone = "Europe/London"
}

#the next 4 resource blocks create the maintenance window targets specifices which resource group to target
resource "aws_ssm_maintenance_window_target" "auto_start_0730_default" {
  window_id     = aws_ssm_maintenance_window.auto_start_0730.id
  name          = "auto_start_0730_default"
  description   = "This is a maintenance window target to identify resources tagged with default tag"
  resource_type = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:Name"
    values = ["default"]
  }
}

resource "aws_ssm_maintenance_window_target" "auto_start_0730_extended" {
  window_id     = aws_ssm_maintenance_window.auto_start_0730.id
  name          = "auto_start_0730_extended"
  description   = "This is a maintenance window target to identify resources tagged with extended tag"
  resource_type = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:Name"
    values = ["extended"]
  }
}

resource "aws_ssm_maintenance_window_target" "auto_stop_1830_default" {
  window_id     = aws_ssm_maintenance_window.auto_stop_1830.id
  name          = "auto_stop_1830_default"
  description   = "This is a maintenance window target to identify resources tagged with default tag"
  resource_type = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:Name"
    values = ["default"]
  }
}

resource "aws_ssm_maintenance_window_target" "auto_start_2100_extended" {
  window_id     = aws_ssm_maintenance_window.auto_stop_2100.id
  name          = "auto_start_2100_extended"
  description   = "This is a maintenance window target to identify resources tagged with extended tag"
  resource_type = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:Name"
    values = ["extended"]
  }
}

# The next 3 resource tasks creates the maintenance window automation tasks, and aligns them to a maintenenance window
# and which targets the automation will run against.
resource "aws_ssm_maintenance_window_task" "auto_start_0730" {
  name = "auto_start_0730"
  description = "Automation task to start EC2 instnaces at 0730"
  max_concurrency = 10
  max_errors      = 4
  priority        = 1
  task_arn        = "AWS-StartEC2Instance"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.auto_start_0730.id
  service_role_arn = "arn:aws:iam::${var.account_id}:role/${var.ssm_role_name}"

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.auto_start_0730_default.id, aws_ssm_maintenance_window_target.auto_start_0730_extended.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = ["{{INSTANCE_ID}}"]
      }
    }
  }
}

resource "aws_ssm_maintenance_window_task" "auto_stop_1830" {
  name = "auto_stop_1830"
  description = "Automation task to stop EC2 instnaces at 1830"
  max_concurrency = 10
  max_errors      = 4
  priority        = 1
  task_arn        = "AWS-StopEC2Instance"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.auto_stop_1830.id
  service_role_arn = "arn:aws:iam::${var.account_id}:role/${var.ssm_role_name}"

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.auto_stop_1830_default.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = ["{{INSTANCE_ID}}"]
      }
    }
  }
}

resource "aws_ssm_maintenance_window_task" "auto_stop_2100" {
  name = "auto_start_2100"
  description = "Automation task to stop EC2 instnaces at 2100"
  max_concurrency = 10
  max_errors      = 4
  priority        = 1
  task_arn        = "AWS-StopEC2Instance"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.auto_stop_2100.id
  service_role_arn = "arn:aws:iam::${var.account_id}:role/${var.ssm_role_name}"

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.auto_start_2100_extended.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"

      parameter {
        name   = "InstanceId"
        values = ["{{INSTANCE_ID}}"]
      }
    }
  }
}