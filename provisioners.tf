data "template_file" "inventory" {
  template = file(var.ansible_inventory_template_path)

  vars = {
    ssh_key_path = var.ssh_key_path
    ansible_user = var.ansible_user
    consul1_ip   = openstack_compute_floatingip_associate_v2.consul[0].floating_ip
    consul2_ip   = openstack_compute_floatingip_associate_v2.consul[1].floating_ip
    consul3_ip   = openstack_compute_floatingip_associate_v2.consul[2].floating_ip
    vault1_ip    = openstack_compute_floatingip_associate_v2.vault[0].floating_ip
    vault2_ip    = openstack_compute_floatingip_associate_v2.vault[1].floating_ip
    vault3_ip    = openstack_compute_floatingip_associate_v2.vault[2].floating_ip
  }
}

resource "null_resource" "update_inventory" {
  triggers = {
    template = data.template_file.inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.ansible_inventory_path}"
  }
}

resource "null_resource" "vault" {
  triggers = {
    cluster_instance_ids = join(",", openstack_compute_instance_v2.vault.*.id)
  }

  connection {
    type        = "ssh"
    user        = var.ansible_user
    timeout     = "2m"
    private_key = file(var.ssh_key_path)
    # FIXME: provide multiple hosts
    host = openstack_compute_floatingip_associate_v2.vault[0].floating_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'uname -a'",
      "uname -a",
    ]
  }

  provisioner "local-exec" {
    command = join("", [
      "ansible-playbook -u '${var.ansible_user}' ",
      "-i '${join(",", openstack_compute_floatingip_associate_v2.vault.*.floating_ip)}, ' ",
      "--private-key '${var.ssh_key_path}' ",
      "--ssh-common-args='-o StrictHostKeyChecking=no' ",
      "${var.ansible_vault_playbook} ",
    ])
  }

  depends_on = [openstack_compute_floatingip_associate_v2.vault]
}

resource "null_resource" "consul" {
  triggers = {
    cluster_instance_ids = join(",", openstack_compute_instance_v2.consul.*.id)
  }

  connection {
    type        = "ssh"
    user        = var.ansible_user
    timeout     = "2m"
    private_key = file(var.ssh_key_path)
    # FIXME: provide multiple hosts
    host = openstack_compute_floatingip_associate_v2.consul[0].floating_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'uname -a'",
      "uname -a",
    ]
  }

  provisioner "local-exec" {
    command = join("", [
      "ansible-playbook -u '${var.ansible_user}' ",
      "-i '${join(",", openstack_compute_floatingip_associate_v2.consul.*.floating_ip)}, ' ",
      "--private-key '${var.ssh_key_path}' ",
      "--ssh-common-args='-o StrictHostKeyChecking=no' ",
      "${var.ansible_consul_playbook} ",
    ])
  }

  depends_on = [openstack_compute_floatingip_associate_v2.consul]
}
