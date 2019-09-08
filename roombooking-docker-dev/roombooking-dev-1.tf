resource "digitalocean_droplet" "roombooking-dev-1" {
  image = "docker-18-04"
  name = "roombooking-dev-1"
  region = "lon1"
  size = "2gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "ufw allow 3000",
      "apt-get update",
      "apt-get -y install git",
      "git clone https://github.com/CHTJonas/roombooking.git /usr/src/app",
      "cd /usr/src/app",
      "git checkout docker",
      "docker-compose build",
      "docker-compose run --rm web 'bin/setup'",
      "docker-compose up"
    ]
  }
}
