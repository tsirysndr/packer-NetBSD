source "qemu" "netbsd" {
  boot_steps            = [
    ["1<enter><wait20s>", "Install NetBSD"],
    ["a<enter><wait10ms>", "Installation messages in English"],
    ["a<enter><wait10ms>", "Keyboard type: unchanged"],
    ["a<down><enter><wait10ms>", "Install NetBSD to hard disk"],
    ["b<enter><wait10ms>", "Yes"],
    ["<enter><wait10ms>", "Yes"],
    ["<down><enter><wait10ms>", ""],
    ["<enter><wait10ms>", ""],
    ["<down><enter><wait10ms>", ""],
    ["<enter><wait10ms>", ""],
    ["<enter><wait10ms>", ""],
    ["<down><enter><wait10s>", ""],
    ["<enter><enter><wait10ms>", ""],
    ["<down><enter><wait10ms>", ""],
    ["<enter><wait120s>", ""],
    ["<enter><wait10ms>", ""],
    ["a<enter><wait10ms><enter><wait10ms><enter><wait10ms><enter><wait10ms><wait20s>", ""],
    ["netbsd-qemu-${var.arch}.local<enter><wait10ms><enter><wait10ms><enter><wait10ms>", ""],
    ["g<enter><wait10ms>", ""],
    ["o<enter><wait10ms>qemu<enter><wait10ms><enter><wait10ms>b<enter><wait5s>", ""],
    ["passw0rd<enter><wait10ms>passw0rd<enter><wait5s>", ""],
    ["x<enter><wait1s>", ""],
    ["<enter><wait5s>", ""],
    ["d<enter>", ""]
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
