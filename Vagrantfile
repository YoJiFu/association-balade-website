# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "public_network"
  
  config.vm.synced_folder "./app", "/var/www/html", 
    owner: "www-data",
    group: "www-data",
    mount_options: ["dmode=777,fmode=777"]

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  config.vm.provision "shell", path: "provision/init.sh"

end