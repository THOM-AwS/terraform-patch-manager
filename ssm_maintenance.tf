
resource "aws_ssm_maintenance_window" "window-scan" {
  count    = var.default_scan ? 1 : 0
  name     = "CMD-Maintenance-Window-Scan-Only"
  schedule =  var.schedule_windows_scan
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window" "window" {
  count    = (local.enabled ? 1 : 0) * length(var.maintenance_windows)
  name     = "CMD-Maintenance-Window-${var.maintenance_windows[count.index]}"
  schedule =  var.schedule_windows[count.index]
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_task" "task_install_patches" {
  count            = (local.enabled ? 1 : 0) * length(var.maintenance_windows)
  name             = "CMD-Maintenance-Window-Patch-${var.maintenance_windows[count.index]}"
  window_id        = aws_ssm_maintenance_window.window[count.index].id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = var.task_install_priority
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors

  targets {
    key    = "WindowTargetIds"
    values = aws_ssm_maintenance_window_target.target_install_a.*.id
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

######## Group SCAN ##########

resource "aws_ssm_maintenance_window_target" "target_install_scan" {
  count         = var.default_scan ? 1 : 0
  name             = "SCAN"
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
      values = ["SCAN"] //var.install_patch_groups
    }
  }
}

######## Group A ##########
resource "aws_ssm_maintenance_window_target" "target_install_a" {
  count         = local.enabled ? 1 : 0
  name          = "AZ-A"
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
      values = ["AZ-A"] //var.install_patch_groups
    }
  }
}


######## Group B ##########

resource "aws_ssm_maintenance_window_target" "target_install_b" {
  count         = local.enabled ? 1 : 0
  name             = "AZ-B"
  window_id     = aws_ssm_maintenance_window.window[1].id
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
      values = ["AZ-B"] //var.install_patch_groups
    }
  }
}

######## Group C ##########

resource "aws_ssm_maintenance_window_target" "target_install_c" {
  count         = local.enabled ? 1 : 0
  name             = "AZ-C"
  window_id     = aws_ssm_maintenance_window.window[2].id
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
      values = ["AZ-C"] //var.install_patch_groups
    }
  }
}