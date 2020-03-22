terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "openstack" {
  version = "~> 1.25"
}

locals {
  ssh_priv_key_path = "./id_rsa_test"
  ssh_pub_key_path  = "./id_rsa_test.pub"
  security_group_ids = [
    data.openstack_networking_secgroup_v2.ingress_ssh.id,
    data.openstack_networking_secgroup_v2.egress_all.id,
  ]
}

module "vault-consul-cluster" {
  source                          = "../"
  vault_cluster_name              = "vault-dev"
  consul_cluster_name             = "consul-dev"
  image_id                        = data.openstack_images_image_v2.ubuntu-1804-LTS.id
  floatingip_pool_name            = "floating"
  network_name                    = data.openstack_networking_network_v2.net_1.name
  vault_security_group_ids        = local.security_group_ids
  consul_security_group_ids       = local.security_group_ids
  ssh_key_pair_name               = "key-dev"
  ssh_key_path                    = local.ssh_priv_key_path
  ansible_inventory_template_path = "../inventory.tpl"
  ansible_vault_playbook          = "../provision_vault.yml"
  ansible_consul_playbook         = "../provision_consul.yml"
}
