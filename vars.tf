
variable "maintenance_windows" {
  description = "To set to be dynamic creation of patch groups by count and name."
  type        = list(string)
  default     = ["AZ-A", "AZ-B", "AZ-C"]
}

variable "default_patch_groups" {
  description = "this allows you to use the aws default patch groups without creating new ones if you dont need to customise settings of a group. Set to false to create your own list of baselines"
  type        = bool
  default     = true
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
  default     = "cron(0 16 ? * SUN *)" // Sunday at 2am AEST
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

# variable "patch_baseline_approval_rules" {
#   description = "A set of rules used to include patches in the baseline. Up to 10 approval rules can be specified. Each `approval_rule` block requires the fields documented below."
#   type = list(object({
#     approve_after_days : number
#     compliance_level : string
#     enable_non_security : bool
#     patch_baseline_filters : list(object({
#       name : string
#       values : list(string)
#     }))
#   }))

#   default = [
#     {
#       approve_after_days  = 7
#       compliance_level    = "HIGH"
#       enable_non_security = true
#       patch_baseline_filters = [
#         {
#           name   = "PRODUCT"
#           values = ["AmazonLinux2", "AmazonLinux2.0"]
#         },
#         {
#           name   = "CLASSIFICATION"
#           values = ["Security", "Bugfix", "Recommended"]
#         },
#         {
#           name   = "SEVERITY"
#           values = ["Critical", "Important", "Medium"]
#         }
#       ]
#     }
#   ]

# }

variable "approved_patches_compliance_level" {
  description = "The list of systems for the SSM baseline"
  type        = string
  default     = "CRITICAL"
}

variable "approved_patches" {
  description = "The list of approved patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "rejected_patches" {
  description = "The list of rejected patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "custom_baselines" { // needed to create a new aws_ssm_patch_baseline
  description = "create a list of custom baselines you want to use instead of the default ones."
  type        = list(string)
  default     = []
}

variable "operating_system" { // needed to create new aws_ssm_patch_baseline and choose OS
  description = "which OS do you want to create a patch baseline for"
  type        = list(string)
  default     = ["WINDOWS"]
}

variable "reboot_option" { // Will the instance reboot for patching
  description = "When you choose the RebootIfNeeded option, the instance is rebooted if Patch Manager installed new patches, or if it detected any patches with a status of INSTALLED_PENDING_REBOOT during the Install operation. Possible values : RebootIfNeeded, NoReboot"
  type        = string
  default     = "RebootIfNeeded"
}

variable "task_install_priority" { // priority for custom aws_ssm_patch_baseline
  description = "The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel."
  type        = number
  default     = 1
}

variable "max_concurrency" { // concurrency for patching window
  description = "The maximum number of targets this task can be run for in parallel"
  type        = number
  default     = 10
}

variable "max_errors" { // errors while patching before fail
  description = "The maximum number of errors allowed before this task stops being scheduled"
  type        = number
  default     = 10
}

variable "client_name" { // customer name for naming convention.
  description = "customer name that is being deployed to. This is required."
  type        = string
}