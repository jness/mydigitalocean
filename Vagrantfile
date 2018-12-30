
Vagrant.configure("2") do |config|

  ## web virtual machine cpu/memory settings
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  ## web virtual machine settings
  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.33.10"

    ## execute setup provision script
    web.vm.provision "shell", path: "packer/scripts/setup.sh"

    ## for salt masterless, copy our mounted salt directory to /srv/salt
    web.vm.provision "shell", name: "Remove /srv/salt", inline: "rm -rf /srv/salt"
    web.vm.provision "shell", name: "Create /srv/salt", inline: "mkdir -p /srv/salt"
    web.vm.provision "shell", name: "Copy /vagrant/salt to /srv/salt", inline: "cp -a /vagrant/salt /srv/"

    ## run salt provision
    web.vm.provision :salt do |salt|
      salt.minion_id  = "web_config"
      salt.masterless = true
      salt.run_highstate = true

      ## setup salt logging
      salt.verbose = true
      salt.colorize = true
      salt.log_level = "debug"
    end

    ## execute cleanup and remove scripts
    web.vm.provision "shell", path: "packer/scripts/cleanup.sh"
    web.vm.provision "shell", path: "packer/scripts/remove.sh"
  end

end
