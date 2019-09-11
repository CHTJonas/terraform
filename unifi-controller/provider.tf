variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

variable "domain_name" {
  type = string
  default = "jfis.co.uk"
}

provider "digitalocean" {
  token = "${var.do_token}"
}
