# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.synced_folder "./mounted_data", "/vagrant_data"

  # Add proxy CA certificate
  # ( comment out this line if you don't have a custom proxy certificate )
  config.vm.provision "file", source: "/usr/local/share/ca-certificates/proxyca.crt",
    destination: "/home/vagrant/resources/proxyca.crt"
  config.vm.provision "shell", path: "scripts/common.sh", args: [ENV['http_proxy'],]

  
  # Add controller node
  config.vm.define "controller" do |controller|
    config.vm.provision "shell", path: "scripts/controller.sh"

    controller.vm.network "private_network", ip: "192.168.7.10"
    controller.vm.provider "virtualbox" do |vb|
      vb.memory = "3000"
    end
  end

  # Add worker node 1
  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: "192.168.7.11"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "1800"
    end
  end

  # Add worker node 2
  config.vm.define "node2" do |node2|
    node2.vm.network "private_network", ip: "192.168.7.12"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "1800"
    end
  end
end
