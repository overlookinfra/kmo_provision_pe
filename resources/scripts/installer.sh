#!/usr/bin/env sh

set -x

#Change the hostname to the FQDN of the master
sudo hostnamectl set-hostname puppet
# Install dependencies
sudo dnf update -y
#change directories to /tmp
cd /tmp
#Download Puppet Enterprise 2021.7.5
sudo curl -JLO 'https://pm.puppetlabs.com/puppet-enterprise/2021.7.5/puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz'
#Unzip the tarball
sudo tar -xvf puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz
#install puppet enterprise
sudo ./puppet-enterprise-2021.7.5-el-8-x86_64/puppet-enterprise-installer -c /tmp/puppet-enterprise-2021.7.5-el-8-x86_64/conf.d/pe.conf

puppet infrastructure console_password --password 'puppetlabs'





