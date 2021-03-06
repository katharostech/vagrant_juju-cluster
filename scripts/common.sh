#/bin/bash

set -ex

http_proxy=$1
no_proxy='127.0.0.1,localhost'
machine_type=$2

# Copy the proxy certificate update the certificate store
cp /home/vagrant/resources/proxyca.crt /usr/local/share/ca-certificates/ || true
update-ca-certificates

# Setup proxy environment variables in profile
echo "export http_proxy=$http_proxy" > /etc/profile.d/00-vagrant.sh
echo "export https_proxy=$http_proxy" >> /etc/profile.d/00-vagrant.sh
echo "export HTTP_PROXY=$http_proxy" >> /etc/profile.d/00-vagrant
echo "export HTTPS_PROXY=$http_proxy" >> /etc/profile.d/00-vagrant
echo "export no_proxy=$no_proxy" >> /etc/profile.d/00-vagrant
echo "export NO_PROXY=$no_proxy" >> /etc/profile.d/00-vagrant

# Setup LXD and snap proxy
snap set system proxy.http=$http_proxy
snap set system proxy.https=$http_proxy
snap set system proxy.ftp=$http_proxy
lxc config set core.proxy_http $http_proxy 
lxc config set core.proxy_https $http_proxy 
lxc config set core.proxy_ignore_hosts $no_proxy

# Allow Vagrant user to ssh as root
mkdir -p /root/.ssh
cat /home/vagrant/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
