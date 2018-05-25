data "template_file" "ipsec_conf" {
        template = "${file("${path.module}/scripts/ipsec-conf.sh")}"
        vars {
                vpn_ip = "${var.m4u_vpn_ip}"        
                vpn_psk = "${var.m4u_vpn_psk}"      
                vpn_psk2 = "${var.m4u_vpn_psk2}"    
                vpn_subnet = "${var.cidrblockvpc}"
                m4u_team_id = "${element(split(".", var.cidrblockvpc),2)}"

        }
}
module "vpn" {
  source = "git::ssh://git@bitbucket.org/git-m4u/arch-instance.git"
  project = "${var.tag_project}"
  environment = "${var.tag_environment}"
  pci = "${var.tag_pci}"
  cost_center = "${var.tag_costcenter}"
  migration = "${var.tag_migration}"
  private_ip = "${cidrhost(cidrsubnet(var.cidrblockvpc,5,0),5)}"
  subnet_id = "${var.subnet_dmza}"
  vpc_security_group_ids = "${var.sg_ipsec_id},${var.sg_nat_id},${var.sg_admin_id}"
  associate_public_ip_address = "true"
  key_name = "${var.key_name}"
  source_dest_check = false
  userdata = "${data.template_file.ipsec_conf.rendered}"
  ami = "ami-b6ef74da"
  instance_type = "t2.micro"
  tag_name = "vpn-instance-a"
  role = "vpn"
}

resource "aws_eip_association" "eip_assoc_vpn_a" {
  instance_id = "${module.vpn.id}"
  allocation_id = "${var.eip_vpn_a_id}"
}
