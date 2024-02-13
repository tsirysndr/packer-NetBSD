source "qemu" "netbsd" {
  boot_steps            = [
    ["1<enter><wait20s>", "Install NetBSD"],
    ["a<enter><wait10ms>", "Installation messages in English"],
    ["a<enter><wait10ms>", "Keyboard type: unchanged"],
    ["a<enter><wait10ms>", "Install NetBSD to hard disk"],
    ["b<enter><wait10ms>", "Yes"],
    ["a<enter><wait10ms>", "Choose disk"],
    ["a<enter><wait10ms>", "Guid Partition Table"],
    ["a<enter><wait10ms>", "This is the correct geometry"],
    ["b<enter><wait10ms>", "Use default partition sizes"],
    ["x<enter><wait10ms>", "Partition sizes ok"],
    ["b<enter><wait10ms>", "Yes"],
    ["a<enter><wait10s>", "Use BIOS Console"],
    ["a<enter><wait10ms>", "Full Installation"],
    ["a<enter><wait300s>", "CD-ROM"],
    ["<enter><wait10ms>", "Hit enter to continue"],
    ["a<enter><wait10ms><enter><wait10ms><enter><wait10ms><enter><wait10ms><wait20s>", "Configure Network"],
    ["netbsd-qemu-${var.arch}.local<enter><wait10ms><enter><wait10ms><enter><wait10ms>", "Your DNS domain"],
    ["g<enter><wait10ms>", "Enable sshd"],
    ["o<enter><wait10ms>qemu<enter><wait10ms><enter><wait10ms>b<enter><wait5s>", "Add user"],
    ["passw0rd<enter><wait10ms>passw0rd<enter><wait5s>", "New password"],
    ["x<enter><wait1s>", "Finished Configuring"],
    ["<enter><wait5s>", "Hit enter to continue"],
    ["d<enter>", "Reboot Computer"]
]
  boot_wait               = "40s"
  cpus                    = "${var.cpus}"
  disk_size               = "${var.disk_size}"
  headless                = true
  iso_checksum            = "md5:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}" 
  memory                  = "${var.memory}"
  shutdown_command        = "su root -c '/sbin/shutdown -p now'"
  ssh_password            = "passw0rd"
  ssh_port                = 22
  ssh_timeout             = "1000s"
  ssh_username            = "qemu"
  vm_name                 = "netbsd-${var.arch}"
  net_device              = "virtio-net"
  disk_interface          = "virtio"
}

build {
  sources = [
    "source.qemu.netbsd",
  ]
}

packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}
