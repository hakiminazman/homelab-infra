resource "proxmox_virtual_environment_container" "adguard" {
  node_name    = var.proxmox_node
  vm_id        = 105
  description  = "<div align='center'>\n  <a href='https://community-scripts.org' target='_blank' rel='noopener noreferrer'>\n    <img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png' alt='Logo' style='width:81px;height:112px;'/>\n  </a>\n\n  <h2 style='font-size: 24px; margin: 20px 0;'>Adguard LXC</h2>\n</div>"
  tags         = ["adblock", "community-script"]
  started      = true
  unprivileged = true

  lifecycle {
    ignore_changes = [
      description,
      operating_system,
      initialization,
      console,
      cpu,
      timeout_clone,
      timeout_create,
      timeout_delete,
      timeout_start,
      timeout_update,
      vm_id,
    ]
  }

  features {
    nesting = true
    keyctl  = true
  }

  initialization {
    hostname = "adguard"

    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.0.105/24"
        gateway = "192.168.0.1"
      }
    }
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 512
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 2
  }

  network_interface {
    name        = "eth0"
    bridge      = "vmbr0"
    mac_address = "BC:24:11:CE:DA:9E"
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    type             = "debian"
  }

  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }

}