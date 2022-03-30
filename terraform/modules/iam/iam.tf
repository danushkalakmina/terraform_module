# Create policies and roles for EC2
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_ec2_role" {
  name               = "${var.Project}-${var.Environment}-beanstalk-EC2InstanceProfile-role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

data "aws_iam_policy" "AWSElasticBeanstalkWebTier" {
  arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "beanstalk_policty_attachment" {
  name       = "rds_policty_attachment"
  roles      = [aws_iam_role.iam_ec2_role.name]
  policy_arn = data.aws_iam_policy.AWSElasticBeanstalkWebTier.arn
  #   roles      = ["${aws_iam_role.iam_rds_role.name}"]
}

# Create ses policy
data "aws_ses_domain_identity" "this" {
  domain = var.domain_name
}

data "template_file" "ses_policy_data" {
  template = file("${path.module}/ses_policy.json")
  vars = {
    Environment    = var.Environment
    domain_arn     = data.aws_ses_domain_identity.this.arn
    ses_send_email = var.ses_send_email
  }
}

resource "aws_iam_policy" "ses_policy" {
  name        = "${var.Project}-${var.Environment}-ses-policy"
  description = "${var.Project}-${var.Environment}-ses-policy"
  policy      = data.template_file.ses_policy_data.rendered
}

resource "aws_iam_policy_attachment" "ses_policy_attachment" {
  name       = "ses_policy_attachment"
  roles      = [aws_iam_role.iam_ec2_role.name]
  policy_arn = aws_iam_policy.ses_policy.arn
}

# Create S3 policy

data "template_file" "s3_policy_data" {
  template = file("${path.module}/s3_policy.json")
  vars = {
    bucket_arn = var.bucket_arn
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "${var.Project}-${var.Environment}-s3-policy"
  description = "${var.Project}-${var.Environment}-s3-policy"
  policy      = data.template_file.s3_policy_data.rendered
}

resource "aws_iam_policy_attachment" "s3_policy_attachment" {
  name       = "s3_policy_attachment"
  roles      = [aws_iam_role.iam_ec2_role.name]
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Create the instance profile

resource "aws_iam_instance_profile" "beanstalk_ec2_instance_profile" {
  name = "${var.Project}-${var.Environment}-instance-profile"
  role = aws_iam_role.iam_ec2_role.name
}
