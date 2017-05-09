# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "shell", inline: <<-SHELL
     sudo cp /vagrant/sources.list /etc/apt/sources.list
     sudo apt-get update
     sudo apt-get upgrade -y
     sudo apt-get install -y vim wget
     sudo apt-get install -t jessie-backports openjdk-8-jdk -y
     sudo ln -s /vagrant/commandline.service /etc/systemd/system/commandline.service
  SHELL
end
