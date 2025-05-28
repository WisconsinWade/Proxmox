resource "proxmox_vm_qemu" "cloudinit-dockerswarm-manager" 
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve"
    desc = "Cloudinit Ubuntu"
    count = 3
    onboot = true

    # The template name to clone this vm from
    clone = "ubuntu-template"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "swarm-manager-0${count.index + 1}"

    cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                  storage = "local-lvm"
                  size = 20
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.17.249.3${count.index + 1}/26,gw=172.17.249.1"
    ciuser = "ubuntu"
    nameserver = "1.1.1.1"
    sshkeys = <<EOF
    # Key Goes Here
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-dockerswam-worker" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve"
    desc = "Cloudinit Ubuntu"
    count = 2
    onboot = true

    # The template name to clone this vm from
    clone = "ubuntu-template"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "swarm-worker-0${count.index + 1}"

    cloudinit_cdrom_storage = "nvme"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                  storage = "nvme"
                  size = 20
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.17.249.3${count.index + 5}/26,gw=172.17.249.1"
    ciuser = "ubuntu"
    sshkeys = <<EOF
    # Key goes here
    EOF
}