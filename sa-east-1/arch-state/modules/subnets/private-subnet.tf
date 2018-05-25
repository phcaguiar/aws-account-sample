resource "aws_subnet" "private-subnet-a" {
    provider = "aws.${var.environment}"
    vpc_id = "${var.vpcid}"
    availability_zone = "${var.region}a"
    cidr_block = "10.10.0.0/24"
    tags {
        Name = "${var.project-name}-private-subnet-a"
    }
}

#resource "aws_route_table_association" "private-a" {
#    subnet_id = "${aws_subnet.private-subnet-a.id}"
#    route_table_id = "${var.routetable-private-id}"
#}

resource "aws_subnet" "private-subnet-c" {
    provider = "aws.${var.environment}"
    vpc_id = "${var.vpcid}"
    availability_zone = "${var.region}c"
#    cidr_block = "${(cidrsubnet(var.base_block_c,4,0))}"
    cidr_block = "10.10.1.0/24"
    tags {
        Name = "${var.project-name}-private-subnet-c"
    }
}

#resource "aws_route_table_association" "private-c" {
#    subnet_id = "${aws_subnet.private-c.id}"
#    route_table_id = "${var.routetable-private-id}"
#}
