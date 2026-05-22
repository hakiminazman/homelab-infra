resource "proxmox_virtual_environment_container" "kavita" {
  node_name    = var.proxmox_node
  vm_id        = 106
  description  = "Kavita LXC"
  tags         = ["media", "community-script"]
  started      = true
  unprivileged = true

  lifecycle {
    ignore_changes = [
      description,
      operating_system,
      initialization,
      console,
      cpu,
    ]
  }

  features {
    nesting = true
  }

  initialization {
    hostname = "kavita"

    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.0.106/24"
        gateway = "192.168.0.1"
      }
    }
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
    type             = "debian"
  }

  mount_point {
    path   = "/mnt/storage"
    volume = "/mnt/storage"
  }
}