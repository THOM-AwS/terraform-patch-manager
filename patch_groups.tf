########## SCAN ##########
resource "aws_ssm_patch_group" "patchgroup-scan-default-windows" {
    count =  9
    baseline_id = data.aws_ssm_patch_baseline[count.index].*.id
    patch_group = "SCAN"
}
# resource "aws_ssm_patch_group" "patchgroup-scan-default-suse" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.suse.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-ubuntu" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.ubuntu.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-debian" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.debian.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-rhel" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.rhel.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-amazon" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.amazon.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-amazon2" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.amazon2.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-centos" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.centos.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-oracle" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.oracle.id
#     patch_group = "SCAN"
# }
# resource "aws_ssm_patch_group" "patchgroup-scan-default-macos" {
#     count =  var.default_scan ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.macos.id
#     patch_group = "SCAN"
# }

########## AZ-A ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-windows-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.windows.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-suse-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.suse.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-ubuntu-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.ubuntu.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-debian-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.debian.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-rhel-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.rhel.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon2-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon2.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-centos-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.centos.id
    patch_group = "AZ-A"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-oracle-A" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.oracle.id
    patch_group = "AZ-A"
}
# resource "aws_ssm_patch_group" "patchgroup-install-default-macos-A" {
#     count =  var.default_patch_groups ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.macos.id
#     patch_group = "AZ-A"
# }

############## AZ-B ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-windows-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.windows.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-suse-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.suse.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-ubuntu-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.ubuntu.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-debian-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.debian.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-rhel-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.rhel.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon2-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon2.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-centos-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.centos.id
    patch_group = "AZ-B"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-oracle-B" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.oracle.id
    patch_group = "AZ-B"
}
# resource "aws_ssm_patch_group" "patchgroup-install-default-macos-B" {
#     count =  var.default_patch_groups ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.macos.id
#     patch_group = "AZ-B"
# }

############## AZ-C ##############
resource "aws_ssm_patch_group" "patchgroup-install-default-windows-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.windows.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-suse-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.suse.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-ubuntu-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.ubuntu.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-debian-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.debian.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-rhel-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.rhel.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-amazon2-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.amazon2.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-centos-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.centos.id
    patch_group = "AZ-C"
}
resource "aws_ssm_patch_group" "patchgroup-install-default-oracle-C" {
    count =  var.default_patch_groups ? 1 : 0
    baseline_id = data.aws_ssm_patch_baseline.oracle.id
    patch_group = "AZ-C"
}
# resource "aws_ssm_patch_group" "patchgroup-install-default-macos-C" {
#     count =  var.default_patch_groups ? 1 : 0
#     baseline_id = data.aws_ssm_patch_baseline.macos.id
#     patch_group = "AZ-C"
# }
