#!/usr/bin/env sh

set -x

# Install dependencies
sudo dnf update -y
#change directories to /tmp
cd /tmp
#Download Puppet Enterprise 2021.7.5
sudo curl -JLO 'https://pm.puppetlabs.com/puppet-enterprise/2021.7.5/puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz'
#Unzip the tarball
sudo tar -xvf puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz