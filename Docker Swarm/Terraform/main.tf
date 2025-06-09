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
    boot            = "order=scsi0;net0"
    
    # CPU Definition
    cpu {
        cores       = 2
        sockets     = 1
        type        = "host"
        numa        = true
    } 

    # Memory Definition
    memory          = 4096

    # Disk Configuration
    scsihw          = "virtio-scsi-pci"
    disks {
        scsi {
            scsi0 {
              disk {
                storage = "local-lvm"
                # This value must match your template
                size    = "25G"
              }  
            }   
        }
        ide {
            # This value must match your template
            ide2 {  
                cloudinit {
                    storage = "local-lvm"
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
    boot            = "order=scsi0;net0"
    
    # CPU Definition
    cpu {
        cores       = 2
        sockets     = 1
        type        = "host"
        numa        = true
    } 

    # Memory Definition
    memory          = 4096

    # Disk Configuration
    scsihw          = "virtio-scsi-pci"
    disks {
        scsi {
            scsi0 {
              disk {
                storage = "local-lvm"
                # This value "XSIZE" must match your template
                size    = "25G"
              }  
            }   
        }
        ide {
            # This value ide(x) must match your template 
            ide2 {
                cloudinit {
                    storage = "local-lvm"
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
