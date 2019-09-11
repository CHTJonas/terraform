resource "digitalocean_droplet" "unifi-controller" {
  image = "docker-18-04"
  name = "unifi-controller"
  region = "lon1"
  size = "s-1vcpu-1gb"
  private_networking = false
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "rm -rf /etc/update-motd.d/99-one-click && echo Instance IP address is $(curl -sS ipecho.net/plain)"
    ]
  }
}

resource "digitalocean_record" "unifi" {
  domain = "${var.domain_name}"
  type   = "A"
  name   = "unifi"
  value  = "${digitalocean_droplet.unifi-controller.ipv4_address}"
}
