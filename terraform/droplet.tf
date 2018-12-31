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

  #####
  ## Set proper permissions on gpg keys
  #####

  provisioner "remote-exec" {
    inline              = "mkdir -p /etc/salt/gpgkeys && chmod 0700 /etc/salt/gpgkeys"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

  #####
  ## Sync gpg keys to droplet
  #####

  provisioner "file" {
    source      = "../gpgkeys/secring.gpg"
    destination = "/etc/salt/gpgkeys/secring.gpg"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }

  }

  provisioner "file" {
    source      = "../gpgkeys/pubring.gpg"
    destination = "/etc/salt/gpgkeys/pubring.gpg"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }

  }

  #####
  ## Set proper permissions on gpg keys
  #####

  provisioner "remote-exec" {
    inline              = "chmod 600 /etc/salt/gpgkeys/*"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

  #####
  ## Run salt-masterless provisioner
  #####

  provisioner "salt-masterless" {
    local_state_tree    = "../salt"
    local_pillar_roots  = "../pillar"
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

  #####
  ## Run post provision scripts
  #####

  provisioner "remote-exec" {
    script              = "../scripts/cleanup.sh"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

  provisioner "remote-exec" {
    script              = "../scripts/remove.sh"

    connection {
      type              = "ssh"
      user              = "root"
      private_key       = "${file("~/.ssh/digitalocean")}"
    }
  }

}
