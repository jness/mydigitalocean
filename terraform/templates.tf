#####
## Generate configuration for droplets from template
#####

data "template_file" "wp_config" {
  template = "${file("files/wp-config.php.tpl")}"

  vars {
    MYSQL_USERNAME = "${var.mysql_username}"
    MYSQL_PASSWORD = "${var.mysql_password}"
    MYSQL_DATABASE = "${var.mysql_database}"
    MYSQL_HOST     = "${digitalocean_droplet.db.ipv4_address_private}"
  }
}
