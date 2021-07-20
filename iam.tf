
resource "aws_iam_role" "ssm_maintenance" {
  name               = "${var.client_name}-role-ssm-patch-manager"
  path               = "/system/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com","ssm.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "role_attach_ssm_mw" {
  role       = aws_iam_role.ssm_maintenance.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}