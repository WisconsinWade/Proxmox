# Docker Swarm Manager Configurations
resource "proxmox_vm_qemu" "dockerswarm-manager" {
    target_node     = "pve"
    count           = 3
    onboot          = "true"

    # VM Definition
    clone           = "ubuntu-template"
    full_clone      = true
    vmid            = "3${count.index + 1}0"
    name            = "dockerswarm-manager-${count.index + 1}"
    agent           = 0
    os_type         = "cloud-init"
    
    # CPU Definition
    cpu {
        cores       = 2
        sockets     = 1
        type        = "host"
        numa        = true
    } 
    
    memory          = 4096

    # Disk Configuration
    scsihw          = "virtio-scsi-pci"
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
            virtio0 {
              disk {
                storage = "local-lvm"
                size    = 20
              }  
            }   
        }
    }

    # Network and IP configuration
    network {
        id          = 0
        model       = "virtio" 
        bridge      = "vmbr0"    
    }
    ipconfig0       = "ip=172.16.249.3${count.index + 1}/24,gw=172.16.249.1"
    nameserver      = "1.1.1.1"

    # Serial Connection for Proxmox
    serial {
        id      = "0"
        type    = "socket"
    }
}

# Docker Swarm Worker Configurations
resource "proxmox_vm_qemu" "dockerswarm-worker" {
    target_node     = "pve"
    count           = 2
    onboot          = "true"

    # VM Definition
    clone           = "ubuntu-template"
    full_clone      = true
    vmid            = "3${count.index + 5}0"
    name            = "dockerswarm-worker-${count.index + 1}"
    agent           = 0
    os_type         = "cloud-init"
    
    # CPU Definition
    cpu {
        cores       = 2
        sockets     = 1
        type        = "host"
        numa        = true
    } 
    
    memory          = 4096

    # Disk Configuration
    scsihw          = "virtio-scsi-pci"
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        virtio {
            virtio0 {
              disk {
                storage = "local-lvm"
                size    = 20
              }  
            }   
        }
    }

    # Network and IP configuration
    network {
        id          = 0
        model       = "virtio" 
        bridge      = "vmbr0"    
    }
    ipconfig0       = "ip=172.16.249.3${count.index + 5}/24,gw=172.16.249.1"
    nameserver      = "1.1.1.1"

    # Serial Connection for Proxmox
    serial {
        id      = "0"
        type    = "socket"
    }
}
