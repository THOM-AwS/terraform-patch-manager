variable "enabled" {
  description = "is the module enabled and will it create resources?"
  type        = bool
  default     = true
}

variable "maintenance_windows" {
  description = "not used yet. want to set to be dynamic creation of patch groups by count and name."
  type = list(string)
  default = [ "AZ-A", "AZ-B", "AZ-C" ]
}

variable "default_patch_groups" {
  description = "this allows you to use the aws default patch groups without creating new ones if you dont need to customise settings of a group."
  type = bool
  default = true
}

variable "default_scan" {
  description = "scan the default patch groups across all AZ's"
  type        = bool
  default     = true
}

variable "schedule_windows" {
  description = "when will each maintenance window be run on cron expression"
  type        = list(string)
  default     = ["cron(0 18 ? * TUE *)", "cron(0 18 ? * WED *)", "cron(0 18 ? * THU *)"] // 4am AEST
}
variable "schedule_windows_scan" {
  description = "when will scanner window be run on cron expression"
  type        = string
  default     = "cron(0 16 ? * SUN *)"  // Daily at 2am AEST
}

variable "install_maintenance_windows_targets" {
  description = "The targets to register with the maintenance window. In other words, the instances to run commands on when the maintenance window runs. You can specify targets using instance IDs, resource group names, or tags that have been applied to instances. For more information about these examples formats see (https://docs.aws.amazon.com/systems-manager/latest/userguide/mw-cli-tutorial-targets-examples.html)"
  type = list(object({
    key : string
    values : list(string)
    }
    )
  )
  default = []
}

variable "reboot_option" {
  description = "When you choose the RebootIfNeeded option, the instance is rebooted if Patch Manager installed new patches, or if it detected any patches with a status of INSTALLED_PENDING_REBOOT during the Install operation. Possible values : RebootIfNeeded, NoReboot"
  type        = string
  default     = "RebootIfNeeded"
}

variable "task_install_priority" {
  description = "The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel."
  type        = number
  default     = 1
}

variable "max_concurrency" {
  description = "The maximum number of targets this task can be run for in parallel"
  type        = number
  default     = 10
}

variable "max_errors" {
  description = "The maximum number of errors allowed before this task stops being scheduled"
  type        = number
  default     = 10
}