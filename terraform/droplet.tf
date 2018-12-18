variable "ssh_key" {}
variable "web_base_image" {}


data "digitalocean_ssh_key" "ssh_key" {
  name = "${var.ssh_key}"
}

data "digitalocean_image" "web_base_image" {
  name = "${var.web_base_image}"
}


resource "digitalocean_droplet" "web" {
  count     = 1
  image     = "${data.digitalocean_image.web_base_image.image}"
  name      = "web-${count.index}"
  region    = "nyc3"
  size      = "512mb"
  ssh_keys  = ["${data.digitalocean_ssh_key.ssh_key.id}"]
  tags      = ["web"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}
