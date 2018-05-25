resource "aws_internet_gateway" "main_internet_gw" {
    provider = "aws.${var.environment}"
    vpc_id = "${var.vpcid}"
    tags {
        Name = "${var.project-name}"
    }
}
