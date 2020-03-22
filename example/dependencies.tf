data "openstack_images_image_v2" "ubuntu-1804-LTS" {
  name        = "Ubuntu-Bionic-Beaver-18.04-LTS"
  most_recent = true
}

data "openstack_networking_secgroup_v2" "egress_all" {
  name = "egress_all"
}

data "openstack_networking_secgroup_v2" "ingress_ssh" {
  name = "ingress_ssh"
}

data "openstack_networking_network_v2" "net_1" {
  name = "net_1"
}
