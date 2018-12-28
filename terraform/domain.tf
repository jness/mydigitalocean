#####
## Provision zone for domain
#####

resource "digitalocean_domain" "default" {
  name = "example-nessy.info"
  ip_address = "${digitalocean_loadbalancer.public.ip}"
}

#####
## Provision records for zone
#####

resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.default.name}"
  type   = "CNAME"
  name = "www"
  value  = "@"
}
