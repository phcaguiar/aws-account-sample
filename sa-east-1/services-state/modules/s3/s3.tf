resource "aws_s3_bucket" "prod" {
  provider = "aws.prod"
  bucket = "${var.project-name}"
  acl    = "private"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowTest",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.account-id}:root"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.project-name}/*"
    }
  ]
}
POLICY
}
