
########## SCAN ##########
resource "aws_ssm_patch_group" "patchgroup-scan-default" {
  count = var.default_scan ? 9 : 0
  baseline_id = element([
    data.aws_ssm_patch_baseline.windows.id,
    data.aws_ssm_patch_baseline.suse.id,
    data.aws_ssm_patch_baseline.ubuntu.id,
    data.aws_ssm_patch_baseline.debian.id,
    data.aws_ssm_patch_baseline.rhel.id,
    data.aws_ssm_patch_baseline.amazon.id,
    data.aws_ssm_patch_baseline.amazon2.id,
    data.aws_ssm_patch_baseline.centos.id,
    data.aws_ssm_patch_baseline.oracle.id
  ], count.index)
  patch_group = "SCAN"
}

########## AZ-A ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-a" {
  count = var.default_patch_groups ? 9 : 0
  baseline_id = element([
    data.aws_ssm_patch_baseline.windows.id,
    data.aws_ssm_patch_baseline.suse.id,
    data.aws_ssm_patch_baseline.ubuntu.id,
    data.aws_ssm_patch_baseline.debian.id,
    data.aws_ssm_patch_baseline.rhel.id,
    data.aws_ssm_patch_baseline.amazon.id,
    data.aws_ssm_patch_baseline.amazon2.id,
    data.aws_ssm_patch_baseline.centos.id,
    data.aws_ssm_patch_baseline.oracle.id
  ], count.index)
  patch_group = var.maintenance_windows[0]
}

############## AZ-B ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-b" {
  count = var.default_patch_groups ? 9 : 0
  baseline_id = element([
    data.aws_ssm_patch_baseline.windows.id,
    data.aws_ssm_patch_baseline.suse.id,
    data.aws_ssm_patch_baseline.ubuntu.id,
    data.aws_ssm_patch_baseline.debian.id,
    data.aws_ssm_patch_baseline.rhel.id,
    data.aws_ssm_patch_baseline.amazon.id,
    data.aws_ssm_patch_baseline.amazon2.id,
    data.aws_ssm_patch_baseline.centos.id,
    data.aws_ssm_patch_baseline.oracle.id
  ], count.index)
  patch_group = var.maintenance_windows[1]
}

############## AZ-C ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-c" {
  count = var.default_patch_groups ? 9 : 0
  baseline_id = element([
    data.aws_ssm_patch_baseline.windows.id,
    data.aws_ssm_patch_baseline.suse.id,
    data.aws_ssm_patch_baseline.ubuntu.id,
    data.aws_ssm_patch_baseline.debian.id,
    data.aws_ssm_patch_baseline.rhel.id,
    data.aws_ssm_patch_baseline.amazon.id,
    data.aws_ssm_patch_baseline.amazon2.id,
    data.aws_ssm_patch_baseline.centos.id,
    data.aws_ssm_patch_baseline.oracle.id
  ], count.index)
  patch_group = var.maintenance_windows[2]
}