# Docker Swarm Manager Configurations
resource "proxmox_vm_qemu" "dockerswarm-manager" {
    target_node     = var.pm_node_name
    count           = 3
    onboot          = "true"

    # VM Definition
    clone           = "ubuntu-template"
    full_clone      = true
    vmid            = "3${count.index + 1}0"
    name            = "dockerswarm-manager-${count.index + 1}"
    agent           = 1
    os_type         = "cloud-init"
    boot            = "order=scsi0;net0"
    
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
    }
    
    # Network and IP configuration
    network {
        id          = 0
        model       = "virtio" 
        bridge      = "vmbr0"    
    }
    ipconfig0       = "ip=172.17.249.3${count.index + 1}/24,gw=172.17.249.1"
    nameserver      = "1.1.1.1"

    # Serial Connection for Proxmox
    serial {
        id          = "0"
        type        = "socket"
    }
    # User information
    ciuser          = "ubuntu"
    cipassword      = "UbuntuPass1234!" 
    sshkeys         = var.public_key
}

# Docker Swarm Worker Configurations
resource "proxmox_vm_qemu" "dockerswarm-worker" {
    target_node     = var.pm_node_name
    count           = 2
    onboot          = "true"

    # VM Definition
    clone           = "ubuntu-template"
    full_clone      = true
    vmid            = "3${count.index + 5}0"
    name            = "dockerswarm-worker-${count.index + 1}"
    agent           = 1
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
    ipconfig0       = "ip=172.17.249.3${count.index + 5}/24,gw=172.17.249.1"
    nameserver      = "1.1.1.1"

    # Serial Connection for Proxmox
    serial {
        id          = "0"
        type        = "socket"
    }
    
    # User information
    ciuser          = "ubuntu"
    cipassword      = var.ci_password
    sshkeys         = var.public_key
}