# create new zone file for domain
resource "digitalocean_domain" "default" {
  name = "example-nessy.info"
  ip_address = "${digitalocean_droplet.web.ipv4_address}"
}

# create A records
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.default.name}"
  type   = "CNAME"
  name = "www"
  value  = "@"
}
