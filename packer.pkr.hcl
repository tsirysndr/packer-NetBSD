source "qemu" "netbsd" {
  boot_command            = [
        "<enter><enter>e<enter><enter>dhcpcd wm0<enter>sleep 2<enter>ftp -o /tmp/i.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install-NetBSD-9-amd64.sh<enter>sh /tmp/i.sh<enter>reboot<enter>"
      ],
  boot_wait               = "40s"
  cpus                    = "${var.cpus}"
  disk_size               = "${var.disk_size}"
  headless                = true
  iso_checksum            = "md5:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}" 
  memory                  = "${var.memory}"
  shutdown_command        = "echo vagrant | sudo -S /sbin/poweroff"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "1000s"
  ssh_username            = "vagrant"
  vm_name                 = "netbsd-${var.arch}"
  net_device              = "virtio-net"
  disk_interface          = "virtio"
}

build {
  sources = [
    "source.qemu.netbsd",
  ]
}

proviosioner "shell" {
  environment_vars = [
    "PROVISIONER=${var.provisioner}",
    "NBSD_RELEASE=${var.release}"
  ]
  execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
  scripts = ["scripts/postinstall.sh"]
}

packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}
