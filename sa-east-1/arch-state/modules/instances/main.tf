variable "cidrblockvpc" {}
variable "sg_ipsec_id" {}
variable "sg_nat_id" {} 
variable "sg_admin_id" {}
variable "subnet_dmza" {} 
variable "subnet_dmzc" {} 
variable "m4u_vpn_ip" {}        
variable "m4u_vpn_psk" {}      
variable "m4u_vpn_psk2" {}  
variable "tag_project" {}
variable "tag_environment" {}
variable "tag_costcenter" {}
variable "tag_migration" {}
variable "tag_pci" { default = "no" }
variable "tag_client" { default = "" }
variable "key_name" { default = "" } 
variable "eip_vpn_a_id" {}
variable "eip_nat_a_id" {}
variable "eip_nat_c_id" {}
