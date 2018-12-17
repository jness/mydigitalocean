# use environment variable TF_VAR_digitalocean_token
variable "digitalocean_token" {}

# configure the digitalocean provider with token
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}
