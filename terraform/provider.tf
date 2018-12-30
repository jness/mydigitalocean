#####
## Provision infrastructure using digitalocean provider
#####

provider "digitalocean" {}

#####
## Lookup digitalocean resources by name
#####

data "digitalocean_ssh_key" "digitalocean_ssh_key_name" {
  name = "${var.digitalocean_ssh_key_name}"
}

data "digitalocean_image" "web_base_image" {
  name = "${var.web_base_image}"
}
