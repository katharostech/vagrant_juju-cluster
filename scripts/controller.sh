#!/bin/bash

set -ex

# Install Juju
snap install juju --classic

# Add the vagrant manual cloud
juju add-cloud --client vagrant-cloud /home/vagrant/resources/vagrant-cloud-definition.yml ||
	juju update-cloud --client vagrant-cloud -f /home/vagrant/resources/vagrant-cloud-definition.yml

# Disable strict host key checking on SSH so we can get through the Juju bootstrap
# without prompts.
echo 'strictHostKeyChecking=off' > ~/.ssh/config
chmod 400 ~/.ssh/config

# Create an ssh key and add it to the authorized keys
rm -f ~/.ssh/id_rsa*
ssh-keygen -t rsa -b 4096 -q -f ~/.ssh/id_rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Bootstrap the Juju controller
juju bootstrap --debug manual/root@localhost vagrant-cloud
