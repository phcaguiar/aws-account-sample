module "nat_c" {
  source = "git::ssh://git@bitbucket.org/git-m4u/arch-instance.git"
  project = "${var.tag_project}"
  environment = "${var.tag_environment}"
  pci = "${var.tag_pci}"
  cost_center = "${var.tag_costcenter}"
  migration = "${var.tag_migration}"
  vpc_security_group_ids =  "${var.sg_nat_id},${var.sg_nat_id}"
  subnet_id = "${var.subnet_dmzc}"
  source_dest_check = false
  associate_public_ip_address = "true"
  key_name = "${var.key_name}"
  instance_type = "t2.nano"
  team = "rede"
  ami = "ami-22169b4e"
  role = "nat"
  tag_name = "nat-instance-c"
}

resource "aws_eip_association" "eip_assoc_nat_c" {
  instance_id = "${module.nat_c.id}"
  allocation_id = "${var.eip_nat_c_id}"
}

