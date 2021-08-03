# Notes

Create patching groups for three teir architecture VPC's with both scan and patch for all OS types.

This is a module in progress for deploying patch manager with maintenance windows across three days, over three AZ's. This will deploy perfect with no arguments. 

Apply a "Patch Group" tag key to all your EC2 instances. the value needs to be either "SCAN" "AZ-A", "AZ-B", or "AZ-C".
You cannot use more than one Key here, so all machines should have the `Patch Group` tag with `SCAN` or one of your AZ's. default is `AZ-A`, `AZ-B`, and `AZ-C` 

Vars file overrides are available for not using the default patch baselines, testing in progress soon for overriding the defaults 
for specific supplied baselines. those will be compatible with the patch groups, or you can also override the tags. 

Patches should be applied to all EC2 machines with "Patch Group" as the key. machines that are pets should all get the value
of the AZ that they reside in. "AZ-A". if the machine should not be patched (its an ASG), then it should get the "SCAN" tag value.

# Terraform AWS SSM Patch Manager

Terraform module for AWS SSM Patch Manager to patch Windows and Linux instances.

## AWS SSM Patch Manager

AWS Systems Manager Patch Manager automates the process of patching managed instances with both security related and other types of updates.

You can patch fleets of EC2 instances or your on-premises servers and virtual machines (VMs) by operating system type.

Patch Manager uses patch baselines, which include rules for auto-approving patches within days of their release, as well as a list of approved and rejected patches. You can install patches on a regular basis by scheduling patching to run as a Systems Manager maintenance window task. You can also install patches individually or to large groups of instances by using Amazon EC2 tags.  

### Patch Baseline

A patch baseline defines which patches are approved for installation on your instances. You can specify approved or rejected patches one by one. You can also create auto-approval rules to specify that certain types of updates (for example, critical updates) should be automatically approved. The rejected list overrides both the rules and the approve list.

Patch Manager provides predefined patch baselines for each of the operating systems supported by Patch Manager. You can use these baselines as they are currently configured (you can’t customize them) or you can create your own custom patch baselines. Custom patch baselines allows you greater control over which patches are approved or rejected for your environment.

### Patch Group

You can use a patch group to associate instances with a specific patch baseline. Patch groups help ensure that you are deploying the appropriate patches, based on the associated patch baseline rules, to the correct set of instances. Patch groups can also help you avoid deploying patches before they have been adequately tested. For example, you can create patch groups for different environments (such as Development, Test, and Production) and register each patch group to an appropriate patch baseline.

## Prerequisites

- **SSM Agent**: Version 2.0.834.0 or later of SSM Agent is running on the instances you want to manage with Patch Manager. You will also need a role with permissions to patch,
ie. managedinstancecore. 

## Considerations

AWS Patch Manager configuration is deployed into every account and region where resources require patching. There is not any functionallity for custom baselines at this point.

## Usage

See example folder.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3 |

## Resources

| Name |
|------|
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/cloudwatch_log_group) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/3/docs/data-sources/iam_policy_document) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/iam_role_policy_attachment) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/iam_role) |
| [aws_sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/sns_topic_subscription) |
| [aws_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/sns_topic) |
| [aws_ssm_maintenance_window_target](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/ssm_maintenance_window_target) |
| [aws_ssm_maintenance_window_task](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/ssm_maintenance_window_task) |
| [aws_ssm_maintenance_window](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/ssm_maintenance_window) |
| [aws_ssm_patch_baseline](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/ssm_patch_baseline) |
| [aws_ssm_patch_group](https://registry.terraform.io/providers/hashicorp/aws/3/docs/resources/ssm_patch_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| TBD | TBD | TBD | TBD | TBD |

## Outputs

TBD



## example main.tf
```
module "patch-manager" {
  source                              = "github.com/THOM-AwS/terraform-patch-manager"
  client_name                         = local.workspace["aws_profile"]
  maintenance_windows                 = local.workspace["maintenance_windows"]
  default_patch_groups                = local.workspace["default_patch_groups"]
  default_scan                        = local.workspace["default_scan"]
  schedule_windows_scan               = local.workspace["schedule_windows_scan"]
  approved_patches_compliance_level   = local.workspace["approved_patches_compliance_level"]
  approved_patches                    = local.workspace["approved_patches"]
  rejected_patches                    = local.workspace["rejected_patches"]
  schedule_windows                    = local.workspace["schedule_windows"]
  custom_baselines                    = local.workspace["custom_baselines"]
  operating_system                    = local.workspace["operating_system"]
  reboot_option                       = local.workspace["reboot_option"]
  task_install_priority               = local.workspace["task_install_priority"]
  max_concurrency                     = local.workspace["max_concurrency"]
  max_errors                          = local.workspace["max_errors"]
}``

## example locals.tf
```
locals {
  env = {
    sandpit = {
      aws_profile           = "cmdlab-sandpit1"
      aws_region            = "ap-southeast-2"
      maintenance_windows   = ["AZ-A", "AZ-B", "AZ-C"]
      default_patch_groups  = true
      default_scan          = true

      ## only matters when not using default baselines:
      schedule_windows      = ["cron(0 18 ? * TUE *)", "cron(0 18 ? * WED *)", "cron(0 18 ? * THU *)"] // 4am AEST
      schedule_windows_scan = "cron(0 16 ? * SUN *)"                                                   // Daily at 2am AEST
      approved_patches_compliance_level = "CRITICAL"
      approved_patches                  = []
      rejected_patches                  = []
      custom_baselines                  = []
      operating_system                  = ["WINDOWS"]
      reboot_option                     = "RebootIfNeeded"
      task_install_priority             = 1
      max_concurrency                   = 10
      max_errors                        = 10
    }
  }
  workspace = local.env[terraform.workspace]
}
```