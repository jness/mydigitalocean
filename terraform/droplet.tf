#####
## Provision digitalocean droplets
#####

resource "digitalocean_droplet" "web" {
  count                 = 1
  image                 = "${data.digitalocean_image.web_base_image.image}"
  name                  = "web-${count.index}"
  region                = "nyc3"
  size                  = "s-1vcpu-1gb"
  private_networking    = "true"
  ssh_keys              = ["${data.digitalocean_ssh_key.digitalocean_ssh_key_name.id}"]
  tags                  = ["web"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "salt-masterless" {
    local_state_tree    = "../salt"
    skip_bootstrap      = "true"
    disable_sudo        = "true"
    remote_state_tree   = "/srv/salt"
    remote_pillar_roots = "/srv/pillar"
    salt_call_args      = "--id=web_config"  # set my minion_id for saltstack's top.sls

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

  provisioner "remote-exec" {
    script              = "../packer/scripts/cleanup.sh"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

}

resource "digitalocean_droplet" "db" {
  count               = 1
  image               = "${data.digitalocean_image.database_base_image.image}"
  name                = "db-${count.index}"
  region              = "nyc3"
  size                = "s-1vcpu-1gb"
  private_networking  = "true"
  ssh_keys            = ["${data.digitalocean_ssh_key.digitalocean_ssh_key_name.id}"]
  tags                = ["db"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "salt-masterless" {
    local_state_tree    = "../salt"
    skip_bootstrap      = "true"
    disable_sudo        = "true"
    remote_state_tree   = "/srv/salt"
    remote_pillar_roots = "/srv/pillar"
    salt_call_args      = "--id=database_config"  # set my minion_id for saltstack's top.sls

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

  provisioner "remote-exec" {
    script              = "../packer/scripts/cleanup.sh"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

}
