[consul_instances]
${consul1_ip} consul_node_name=consul1 consul_node_role=bootstrap
${consul2_ip} consul_node_name=consul2 consul_node_role=server
${consul3_ip} consul_node_name=consul3 consul_node_role=server

[vault_1]
${vault1_ip}

[vault_2]
${vault2_ip}

[vault_3]
${vault3_ip}

[vault_instances:children]
vault_1
vault_2
vault_3

[all:vars]
ansible_connection=ssh
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_ssh_private_key_file=${ssh_key_path}
ansible_ssh_user=${ansible_user}
