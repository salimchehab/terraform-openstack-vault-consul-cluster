output "vault_access_ips" {
  description = "A list of the ip_v4 of the vault instances."
  value       = openstack_compute_instance_v2.vault.*.access_ip_v4
}

output "vault_floating_ips" {
  description = "A list of the floating_ip of the vault instances."
  value       = openstack_compute_floatingip_associate_v2.vault.*.floating_ip
}

output "consul_access_ips" {
  description = "A list of the ip_v4 of the consul instances."
  value       = openstack_compute_instance_v2.consul.*.access_ip_v4
}

output "consul_floating_ips" {
  description = "A list of the floating_ip of the consul instances."
  value       = openstack_compute_floatingip_associate_v2.consul.*.floating_ip
}
