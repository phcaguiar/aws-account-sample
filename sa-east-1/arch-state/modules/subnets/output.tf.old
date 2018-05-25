output "base_subnet_a" {
	value = "${element(split(".", var.cidrblockvpc), 0)}.${element(split(".", var.cidrblockvpc),1)}.${element(split(".", var.cidrblockvpc),2)}.0"
} 
output "base_subnet_c" {
        value =  "${element(split(".", var.cidrblockvpc), 0)}.${element(split(".", var.cidrblockvpc),1)}.${element(split(".", var.cidrblockvpc),2) + 1 }.0"
}
output "subnet_db_a_id" {
	value = "${aws_subnet.db_a.id}"
} 
output "subnet_db_c_id" {
        value = "${aws_subnet.db_c.id}"
} 
output "subnet_dmz_a_id" {
        value = "${aws_subnet.dmz_a.id}"
} 
output "subnet_dmz_c_id" {
        value = "${aws_subnet.dmz_c.id}"
}
