#####
## Provision digitalocean droplets
#####

resource "digitalocean_droplet" "web" {
  count               = 1
  image               = "${data.digitalocean_image.web_base_image.image}"
  name                = "web-${count.index}"
  region              = "nyc3"
  size                = "512mb"
  private_networking  = "true"
  ssh_keys            = ["${data.digitalocean_ssh_key.digitalocean_ssh_key_name.id}"]
  tags                = ["web"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "file" {
    content      = "${data.template_file.wp_config.rendered}"
    destination = "/var/www/wordpress/wp-config.php"
  }

}

resource "digitalocean_droplet" "db" {
  count               = 1
  image               = "${data.digitalocean_image.database_base_image.image}"
  name                = "db-${count.index}"
  region              = "nyc3"
  size                = "512mb"
  private_networking  = "true"
  ssh_keys            = ["${data.digitalocean_ssh_key.digitalocean_ssh_key_name.id}"]
  tags                = ["db"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 30"
    environment {
      MYSQL_USERNAME = "${var.mysql_username}"
      MYSQL_PASSWORD = "${var.mysql_password}"
      MYSQL_DATABASE = "${var.mysql_database}"
    }
  }

}
