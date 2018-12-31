#####
## Provision loadbalancer for web droplets
#####

resource "digitalocean_loadbalancer" "public" {
  name = "loadbalancer-1"
  region = "nyc3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  healthcheck {
    port = 80
    protocol = "http"
    path = "/"
  }

  droplet_tag = "web"
}
