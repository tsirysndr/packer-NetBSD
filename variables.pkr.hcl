variable "arch" {
  type = string
  default = "amd64"
}

variable "cpus" {
  type = number
  default = 1
}

variable "disk_size" {
  type = number
  default = 10240
}

variable "memory" {
  type = number
  default = 1024
}

variable "iso_url" {
  type = string
  default = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/images/NetBSD-9.3-amd64.iso"
}

variable "iso_checksum" {
  type = string
  default = "d37728b4a9c6f48e01723f65161cbbae"
}
