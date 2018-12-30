# **MyDigitalOcean**

A learning exercise involving provisioning Digital Ocean using the following [HashiCorp](https://www.hashicorp.com/) technologies:

  * [Packer](https://www.packer.io/docs/builders/digitalocean.html)
  * [Terraform](https://www.terraform.io/docs/providers/do/index.html)

I'm also using [SaltStack](https://www.saltstack.com/) as a **provisioner** during build (Packer) and configuration (Terraform) runs.

A [Vagrantfile](https://www.vagrantup.com/) exists for local testing and development via [VirtualBox](https://www.virtualbox.org/):

```
vagrant up
```
