# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

datacenter = "habay"
data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  # license_path is required as of Nomad v1.1.1+
  #license_path = "/opt/nomad/license.hclic"
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
  servers = ["127.0.0.1"]

  host_volume "etc-pihole" {
    path      = "/opt/pihole/etc-pihole/"  #"/home/georgiem/etc-pihole/"
    read_only = false
  }

  host_volume "etc-dnsmasq.d" {
    path      = "/opt/pihole/etc-dnsmasq.d/" #"/home/georgiem/etc-dnsmasq.d/"
    read_only = false
  }

}

plugin "docker" {
  config {
    allow_privileged = false

    volumes {
      enabled      = true
      selinuxlabel = "z"
    }
  }
}