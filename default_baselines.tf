
# # Patch Baselines - not implemented in this version. perhaps added later.
# resource "aws_ssm_patch_baseline" "baselinecustom" {
#   count            = (var.default_patch_groups ? 0 : 1) * length(var.custom_baselines)
#   name             = "Patch-Manager-Custom-${var.operating_system}"
#   description      = "${var.operating_system} baseline"
#   operating_system = var.operating_system[count.index]

#   approved_patches                  = var.approved_patches
#   rejected_patches                  = var.rejected_patches
#   approved_patches_compliance_level = var.approved_patches_compliance_level

#   dynamic "approval_rule" {
#     for_each = toset(var.patch_baseline_approval_rules)
#     content {

#       approve_after_days  = approval_rule.value.approve_after_days
#       compliance_level    = approval_rule.value.compliance_level
#       enable_non_security = approval_rule.value.enable_non_security

#       # https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-patch-properties.html
#       dynamic "patch_filter" {
#         for_each = approval_rule.value.patch_baseline_filters

#         content {
#           key    = patch_filter.value.name
#           values = patch_filter.value.values
#         }
#       }
#     }
#   }
# }


data "aws_ssm_patch_baseline" "windows" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "WINDOWS"
}
data "aws_ssm_patch_baseline" "suse" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "SUSE"
}
data "aws_ssm_patch_baseline" "ubuntu" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "UBUNTU"
}
data "aws_ssm_patch_baseline" "debian" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "DEBIAN"
}
data "aws_ssm_patch_baseline" "rhel" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "REDHAT_ENTERPRISE_LINUX"
}
data "aws_ssm_patch_baseline" "amazon" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "AMAZON_LINUX"
}
data "aws_ssm_patch_baseline" "amazon2" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "AMAZON_LINUX_2"
}
data "aws_ssm_patch_baseline" "centos" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "CENTOS"
}
data "aws_ssm_patch_baseline" "oracle" {
  owner            = "AWS"
  name_prefix      = "AWS-"
  default_baseline = true
  operating_system = "ORACLE_LINUX"
}
# data "aws_ssm_patch_baseline" "macos" {
#   owner            = "AWS"
#   name_prefix      = "AWS-"
#   default_baseline = true
#   operating_system = "MACOS"
# }