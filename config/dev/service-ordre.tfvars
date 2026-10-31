service = "ordre"
runtime = "vm"

prefix = "10.10.0.0/24"

ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGMQ32gu8mGVI86gkUex5JsBeg7WC58bsUOVuxmeHDJW oblig2-ingen-privat-nokkel"

allow_http_from = "Internet"
vm_size         = "Standard_B2als_v2"

extra_tcp_rules = {
  allow-tcp-8933 = {
    port        = 8933
    source_cidr = "172.16.25.0/24"
    priority    = 110
  }
}