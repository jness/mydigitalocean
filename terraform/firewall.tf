#####
## Provision firewall for web droplets
#####

resource "digitalocean_firewall" "web" {
  name = "web_rules"
  tags = ["web"]

  inbound_rule = [
    {
      protocol                  = "tcp"
      port_range                = "22"
      source_addresses          = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                  = "tcp"
      port_range                = "80"
      source_load_balancer_uids = ["${digitalocean_loadbalancer.public.id}"]
    }
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  ]
}


#####
## Provision firewall for database droplets
#####

resource "digitalocean_firewall" "db" {
  name = "database_rules"
  tags = ["db"]

  inbound_rule = [
    {
      protocol                  = "tcp"
      port_range                = "22"
      source_addresses          = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                  = "tcp"
      port_range                = "3306"
      source_tags               = ["web"]
    }
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "1-65535"
      destination_tags        = ["web"]
    }
  ]
}
