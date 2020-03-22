# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated to 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

resource "openstack_compute_instance_v2" "vault" {
  count = var.vault_cluster_size

  name            = "${var.vault_cluster_name}-${count.index}"
  flavor_name     = var.vault_instance_flavor
  key_pair        = var.ssh_key_pair_name
  security_groups = var.vault_security_group_ids
  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.vault_instance_volume_size
    boot_index            = 0
    delete_on_termination = true
  }
  network {
    name = var.network_name
  }
}

resource "openstack_compute_instance_v2" "consul" {
  count = var.consul_cluster_size

  name            = "${var.consul_cluster_name}-${count.index}"
  flavor_name     = var.consul_instance_flavor
  key_pair        = var.ssh_key_pair_name
  security_groups = var.consul_security_group_ids
  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.consul_instance_volume_size
    boot_index            = 0
    delete_on_termination = true
  }
  network {
    name = var.network_name
  }
}

resource "openstack_networking_floatingip_v2" "vault" {
  count = var.vault_cluster_size

  pool = var.floatingip_pool_name
}

resource "openstack_networking_floatingip_v2" "consul" {
  count = var.consul_cluster_size

  pool = var.floatingip_pool_name
}

resource "openstack_compute_floatingip_associate_v2" "vault" {
  count = var.vault_cluster_size

  floating_ip = element(openstack_networking_floatingip_v2.vault.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.vault.*.id, count.index)
}

resource "openstack_compute_floatingip_associate_v2" "consul" {
  count = var.consul_cluster_size

  floating_ip = element(openstack_networking_floatingip_v2.consul.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.consul.*.id, count.index)
}
