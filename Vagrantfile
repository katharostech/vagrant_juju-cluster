# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.synced_folder "./mounted_data", "/vagrant_data"

  # Add proxy CA certificate
  # ( comment out this line if you don't have a custom proxy certificate )
  config.vm.provision "file", source: "/usr/local/share/ca-certificates/proxyca.crt",
    destination: "/home/vagrant/resources/proxyca.crt"
  # Add Vagrant ssh key
  config.vm.provision "file", source: "./resources/vagrant_id_rsa",
    destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision "file", source: "./resources/vagrant_id_rsa.pub",
    destination: "/home/vagrant/.ssh/id_rsa.pub"
  # Add vagrant Juju cloud definition yaml
  config.vm.provision "file", source: "./resources/vagrant-cloud-definition.yml",
    destination: "/home/vagrant/resources/vagrant-cloud-definition.yml"

  # Run VM config script
  config.vm.provision "shell", path: "scripts/common.sh", args: [ENV['http_proxy'],]

  
  # Add controller node
  config.vm.define "controller" do |controller|
    # Set VM Hostname
    controller.vm.provision "shell", inline: "set -ex; hostnamectl set-hostname juju-controller"

    # Run controller config script
    controller.vm.provision "shell", path: "scripts/controller.sh"

    controller.vm.network "private_network", ip: "192.168.7.10"
    controller.vm.provider "virtualbox" do |vb|
      vb.memory = "3000"
    end
  end

  # Add worker node 1
  config.vm.define "node1" do |node1|
    # Set VM Hostname
    node1.vm.provision "shell", inline: "set -ex; hostnamectl set-hostname juju-node1"

    node1.vm.network "private_network", ip: "192.168.7.11"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "1800"
    end
  end

  # Add worker node 2
  config.vm.define "node2" do |node2|
    # Set VM Hostname
    node2.vm.provision "shell", inline: "set -ex; hostnamectl set-hostname juju-node2"

    node2.vm.network "private_network", ip: "192.168.7.12"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "1800"
    end
  end
end
