resource "aws_vpc" "main-vpc" {
    provider = "aws.${var.environment}"
#   cidr_block = "10.0.0.0/16"
    cidr_block = "${var.cidrblockvpc}"
    
    tags {
        Name = "${var.project-name}-vpc"
    }
}

#resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
#    vpc_id = "${aws_vpc.main-vpc.id}"
#    dhcp_options_id = "${aws_vpc_dhcp_options.dhcp-options.id}"
#}
#resource "aws_main_route_table_association" "route_default" {
#    vpc_id = "${aws_vpc.main-vpc.id}"
#    route_table_id = "${var.mainvpcassoc_routetabledefaultaid}"
#}
