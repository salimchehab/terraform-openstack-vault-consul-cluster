# Summary

This module creates the necessary OpenStack infrastructure for HashiCorp Vault with Consul.

The default value for the number of servers is 3. The module assigns floating IPs for the OpenStack servers and are populated in the [outputs](./outputs.tf) file.

There are local and remote exec in the [provisioners](./provisioners.tf) file. They can be used to execute initial bootstrap-relevant commands when provisioning the infrastructure.

The following environment variables are picked up by OpenStack for provisioning and should be set if a `clouds.yaml` file is not available:

    - OS_AUTH_URL
    - OS_CACERT
    - OS_IDENTITY_API_VERSION
    - OS_INTERFACE
    - OS_PASSWORD
    - OS_PROJECT_DOMAIN_ID
    - OS_PROJECT_ID
    - OS_USER_DOMAIN_NAME
    - OS_USERNAME

The [requirements](./requirements.yml) file contains the Ansible roles that could be used for installation of Vault and Consul. They could be installed locally as follows:
```text
$ ansible-galaxy install -r requirements.yml
```

There is a template [file](./inventory.tpl) to generate the Ansible inventory as needed. This might have to be adjusted according to the number of nodes available in the cluster.

# Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ansible\_consul\_playbook | The name of the ansible playbook to be executed by the local provisioner on the Consul cluster. | string | `"provision_consul.yml"` | no |
| ansible\_inventory\_path | The path used to render the ansible inventory templates for the compute instances. | string | `"./inventory"` | no |
| ansible\_inventory\_template\_path | The path of the terraform template used to render the ansible inventory. | string | `"./inventory.tpl"` | no |
| ansible\_user | The user used for SSH login to the compute instances. | string | `"ubuntu"` | no |
| ansible\_vault\_playbook | The name of the ansible playbook to be executed by the local provisioner on the Vault cluster. | string | `"provision_vault.yml"` | no |
| consul\_cluster\_name | What to name the Consul server cluster and all of its associated resources. | string | `"consul-example"` | no |
| consul\_cluster\_size | The number of Consul server nodes to deploy. Recommended is 3 or 5. | number | `"3"` | no |
| consul\_cluster\_tag\_key | The tag the Consul instances will look for to automatically discover each other and form a cluster. | string | `"consul-servers"` | no |
| consul\_instance\_flavor | The flavor of compute instance to run in the Consul cluster. | string | `"2.08.default"` | no |
| consul\_instance\_volume\_size | The size in GB of the boot volume for the Consul compute instances. | number | `"50"` | no |
| consul\_security\_group\_ids | The security group ids to be attached to the Consul compute instances being created. | list(string) | n/a | yes |
| floatingip\_pool\_name | The pool name where from where the floating ips will be taken. | string | n/a | yes |
| image\_id | The ID of the for the image to run in the cluster. | string | n/a | yes |
| network\_name | The network name where the compute instances will be created. | string | n/a | yes |
| ssh\_key\_pair\_name | The name of a Key Pair for the compute instance that can be used for SSH. | string | n/a | yes |
| ssh\_key\_path | The path to the private ssh key on the localhost that matches the Key Pair from above. | string | n/a | yes |
| vault\_cluster\_name | What to name the Vault server cluster and all of its associated resources. | string | `"vault-example"` | no |
| vault\_cluster\_size | The number of Vault server nodes to deploy. Recommended is 3 or 5. | number | `"3"` | no |
| vault\_instance\_flavor | The flavor of compute instance to run in the Vault cluster. | string | `" 2.04.default"` | no |
| vault\_instance\_volume\_size | The size in GB of the boot volume for the Vault compute instances. | number | `"25"` | no |
| vault\_security\_group\_ids | The security group ids to be attached to the Vault compute instances being created. | list(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| consul\_access\_ips | A list of the ip_v4 of the consul instances. |
| consul\_floating\_ips | A list of the floating_ip of the consul instances. |
| vault\_access\_ips | A list of the ip_v4 of the vault instances. |
| vault\_floating\_ips | A list of the floating_ip of the vault instances. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Terraform Outputs Example

Outputs for the example folder:
```text
Outputs:

consul_floating_ips = [
  "10.98.36.200",
  "10.98.36.201",
  "10.98.36.202",
]
vault_floating_ips = [
  "10.98.36.100",
  "10.98.36.101",
  "10.98.36.102",
]
```
