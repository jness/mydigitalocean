variable "web_base_image" {}

data "digitalocean_image" "web_base_image" {
  name = "${var.web_base_image}"
}

# create a new droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image  = "${data.digitalocean_image.web_base_image.image}"
  name   = "web-01"
  region = "nyc3"
  size   = "512mb"

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}
