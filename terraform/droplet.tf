variable "base_image" {}

data "digitalocean_image" "base_image" {
  name = "${var.base_image}"
}

# create a new droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image  = "${data.digitalocean_image.base_image.image}"
  name   = "web-01"
  region = "nyc3"
  size   = "s-1vcpu-1gb"

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}
