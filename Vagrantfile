
Vagrant.configure("2") do |config|

  ## web virtual machine cpu/memory settings
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end

  ## web virtual machine settings
  config.vm.define "web" do |web|
    web.vm.hostname = "web"
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.33.10"

    ## execute setup provision script
    web.vm.provision "shell", path: "scripts/setup.sh"

    ## for salt masterless, copy our mounted salt directory to /srv/salt
    web.vm.provision "shell", name: "Remove /srv/salt", inline: "rm -rf /srv/salt"
    web.vm.provision "shell", name: "Create /srv/salt", inline: "mkdir -p /srv/salt"
    web.vm.provision "shell", name: "Copy /vagrant/salt to /srv/salt", inline: "cp -a /vagrant/salt /srv/"

    ## for salt masterless, copy our mounted pillar directory to /srv/pillar
    web.vm.provision "shell", name: "Remove /srv/pillar", inline: "rm -rf /srv/pillar"
    web.vm.provision "shell", name: "Create /srv/pillar", inline: "mkdir -p /srv/pillar"
    web.vm.provision "shell", name: "Copy /vagrant/pillar to /srv/pillar", inline: "cp -a /vagrant/pillar /srv/"

    ## copy gpg keys into salt path
    web.vm.provision "shell", name: "Create /etc/salt/gpgkeys", inline: "mkdir -p /etc/salt/gpgkeys && chmod 0700 /etc/salt/gpgkeys"
    web.vm.provision "shell", name: "Copy /gpgkeys/pubring.gpg", inline: "cp /vagrant/gpgkeys/pubring.gpg /etc/salt/gpgkeys/pubring.gpg && chmod 600 /etc/salt/gpgkeys/pubring.gpg"
    web.vm.provision "shell", name: "Copy /gpgkeys/secring.gpg", inline: "cp /vagrant/gpgkeys/secring.gpg /etc/salt/gpgkeys/secring.gpg && chmod 600 /etc/salt/gpgkeys/secring.gpg"

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
    web.vm.provision "shell", path: "scripts/cleanup.sh"
    web.vm.provision "shell", path: "scripts/remove.sh"
  end

end
