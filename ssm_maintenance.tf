
resource "aws_ssm_maintenance_window" "window-scan" {
  count    = var.default_scan ? 1 : 0
  name     = "${var.client_name}-Maintenance-Window-Scan-Only"
  schedule = var.schedule_windows_scan
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window" "window" {
  count    = (var.default_patch_groups ? 1 : 0) * length(var.maintenance_windows)
  name     = "${var.client_name}-Maintenance-Window-Patch-${var.maintenance_windows[count.index]}"
  schedule = var.schedule_windows[count.index]
  duration = 3
  cutoff   = 1
}

########## TASK ##########
resource "aws_ssm_maintenance_window_task" "task_install_patches" {
  count            = (var.default_patch_groups ? 1 : 0) * length(var.maintenance_windows)
  name             = "${var.client_name}-Maintenance-Window-Patch-${var.maintenance_windows[count.index]}"
  window_id        = aws_ssm_maintenance_window.window[count.index].id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  service_role_arn = aws_iam_role.ssm_maintenance.arn
  priority         = var.task_install_priority
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key    = "WindowTargetIds"
    values = aws_ssm_maintenance_window_target.target_install.*.id
  }

  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Install"]
      }
      parameter {
        name   = "RebootOption"
        values = [var.reboot_option]
      }
    }
  }
}

resource "aws_ssm_maintenance_window_task" "task_scan" {
  count            = var.default_scan ? 1 : 0
  name             = "${var.client_name}-Maintenance-Window-Patch-Scan"
  window_id        = aws_ssm_maintenance_window.window-scan[0].id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  service_role_arn = aws_iam_role.ssm_maintenance.arn
  priority         = var.task_install_priority
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key    = "WindowTargetIds"
    values = aws_ssm_maintenance_window_target.target_install_scan.*.id
  }

  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Scan"]
      }
      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
    }
  }
}

######## Group SCAN ##########

resource "aws_ssm_maintenance_window_target" "target_install_scan" {
  count         = var.default_scan ? 1 : 0
  name          = "SCAN"
  window_id     = aws_ssm_maintenance_window.window-scan[0].id
  resource_type = "INSTANCE"

  dynamic "targets" {
    for_each = toset(var.install_maintenance_windows_targets)
    content {
      key    = targets.value.key
      values = targets.value.values
    }
  }

  dynamic "targets" {
    for_each = length(var.install_maintenance_windows_targets) == 0 ? [1] : []
    content {
      key    = "tag:Patch Group"
      values = ["SCAN"]
    }
  }
}

######## Group Install ##########
resource "aws_ssm_maintenance_window_target" "target_install" {
  count         = (var.default_patch_groups ? 1 : 0) * length(var.maintenance_windows)
  name          = var.maintenance_windows[count.index]
  window_id     = aws_ssm_maintenance_window.window[count.index].id
  resource_type = "INSTANCE"

  dynamic "targets" {
    for_each = toset(var.install_maintenance_windows_targets)
    content {
      key    = targets.value.key
      values = targets.value.values
    }
  }

  dynamic "targets" {
    for_each = length(var.install_maintenance_windows_targets) == 0 ? [1] : []
    content {
      key    = "tag:Patch Group"
      values = [var.maintenance_windows[count.index]]
    }
  }
}
