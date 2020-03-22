output "vault_floating_ips" {
  description = "The floating IPs of the Vault instances."
  value       = module.vault-consul-cluster.vault_floating_ips
}

output "consul_floating_ips" {
  description = "The floating IPs of the Consul instances."
  value       = module.vault-consul-cluster.consul_floating_ips
}
