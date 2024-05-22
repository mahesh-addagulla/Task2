resource "time_sleep" "delay" {
  depends_on      = [null_resource.vm-config]
  create_duration = "10s"
}

resource "null_resource" "vm-config" {
  count = var.env == "Development" || var.env == "development" || var.env == "dev" || var.env == "Dev" ? 3 : 1
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type     = "ssh"
      user     = "adminsree"
      password = element(azurerm_key_vault_secret.password1_secret.*.value, count.index)
      host     = element(azurerm_public_ip.vms.*.ip_address, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "bash /tmp/script.sh",
      "sudo apt update ",
      "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
      "chmod 777 /home/adminsree/kubectl && ./kubectl version | head -1",
      "sudo apt install -y nginx jq unzip net-tools python3-pip",
      "sudo snap install certbot --classic",
      "sudo echo '<h1>${azurerm_resource_group.azb40rg1.name}-PublicServer-${count.index + 1}</h1>' | sudo tee -a  /var/www/html/index.nginx-debian.html"

    ]
    connection {
      type     = "ssh"
      user     = "adminsree"
      password = element(azurerm_key_vault_secret.password1_secret.*.value, count.index)
      host     = element(azurerm_public_ip.vms.*.ip_address, count.index)
    }
  }
  depends_on = [azurerm_subnet_network_security_group_association.nsg-assosiation-websvr, azurerm_linux_virtual_machine.vms]
}
