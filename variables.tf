# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables in order to create machines using OpenStack
# ---------------------------------------------------------------------------------------------------------------------

# OS_AUTH_URL
# OS_CACERT
# OS_IDENTITY_API_VERSION
# OS_INTERFACE
# OS_PASSWORD
# OS_PROJECT_DOMAIN_ID
# OS_PROJECT_ID
# OS_USER_DOMAIN_NAME
# OS_USERNAME

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "image_id" {
  description = "The ID of the for the image to run in the cluster."
  type        = string
}

variable "floatingip_pool_name" {
  description = "The pool name where from where the floating ips will be taken."
  type        = string
}

variable "network_name" {
  description = "The network name where the compute instances will be created."
  type        = string
}

variable "vault_security_group_ids" {
  description = "The security group ids to be attached to the Vault compute instances being created."
  type        = list(string)
}

variable "consul_security_group_ids" {
  description = "The security group ids to be attached to the Consul compute instances being created."
  type        = list(string)
}

variable "ssh_key_pair_name" {
  description = "The name of a Key Pair for the compute instance that can be used for SSH."
  type        = string
}

variable "ssh_key_path" {
  description = "The path to the private ssh key on the localhost that matches the Key Pair from above."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "vault_cluster_name" {
  description = "What to name the Vault server cluster and all of its associated resources."
  type        = string
  default     = "vault-example"
}

variable "consul_cluster_name" {
  description = "What to name the Consul server cluster and all of its associated resources."
  type        = string
  default     = "consul-example"
}

variable "vault_cluster_size" {
  description = "The number of Vault server nodes to deploy. Recommended is 3 or 5."
  type        = number
  default     = 3
}

variable "consul_cluster_size" {
  description = "The number of Consul server nodes to deploy. Recommended is 3 or 5."
  type        = number
  default     = 3
}

variable "vault_instance_flavor" {
  description = "The flavor of compute instance to run in the Vault cluster."
  type        = string
  default     = "2.04.default"
}

variable "consul_instance_flavor" {
  description = "The flavor of compute instance to run in the Consul cluster."
  type        = string
  default     = "2.08.default"
}

variable "consul_cluster_tag_key" {
  description = "The tag the Consul instances will look for to automatically discover each other and form a cluster."
  type        = string
  default     = "consul-servers"
}

variable "vault_instance_volume_size" {
  description = "The size in GB of the boot volume for the Vault compute instances."
  type        = number
  default     = 25
}

variable "consul_instance_volume_size" {
  description = "The size in GB of the boot volume for the Consul compute instances."
  type        = number
  default     = 50
}

variable "ansible_user" {
  description = "The user used for SSH login to the compute instances."
  type        = string
  default     = "ubuntu"
}

variable "ansible_inventory_template_path" {
  description = "The path of the terraform template used to render the ansible inventory."
  type        = string
  default     = "./inventory.tpl"
}

variable "ansible_inventory_path" {
  description = "The path used to render the ansible inventory templates for the compute instances."
  type        = string
  default     = "./inventory"
}

variable "ansible_vault_playbook" {
  description = "The name of the ansible playbook to be executed by the local provisioner on the Vault cluster."
  type        = string
  default     = "provision_vault.yml"
}

variable "ansible_consul_playbook" {
  description = "The name of the ansible playbook to be executed by the local provisioner on the Consul cluster."
  type        = string
  default     = "provision_consul.yml"
}
