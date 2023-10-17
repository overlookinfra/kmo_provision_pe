#!/usr/bin/env sh

set -x

# Prepare /etc/hosts
sudo sed -i '/^127\.0\.0\.1/ s/$/ puppet/' /etc/hosts
sudo sed -i '/^::1/ s/$/ puppet/' /etc/hosts
sudo sed -i 's/\(^[0-9.]*\).*\.c\.kmo-instruqt\.internal/\1 puppet.c.kmo-instruqt.internal/' /etc/hosts
sudo sed -i 's/\(puppet\.c\.kmo-instruqt\.internal\).*/\1 puppet/' /etc/hosts


#Change the hostname to the FQDN of the master
sudo hostnamectl set-hostname puppet



#change directories to /tmp
cd /tmp
#Download Puppet Enterprise 2021.7.5
sudo curl -JLO 'https://pm.puppetlabs.com/puppet-enterprise/2021.7.5/puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz'
#Unzip the tarball
sudo tar -xvf puppet-enterprise-2021.7.5-el-8-x86_64.tar.gz
#install puppet enterprise
sudo ./puppet-enterprise-2021.7.5-el-8-x86_64/puppet-enterprise-installer -c /tmp/puppet-enterprise-2021.7.5-el-8-x86_64/conf.d/pe.conf

#Need to run puppet agent as root twice to get the cert signed
sudo /opt/puppetlabs/bin/puppet agent -t
sudo /opt/puppetlabs/bin/puppet agent -t


#Set the console password
sudo /opt/puppetlabs/bin/puppet infrastructure console_password --password 'puppetlabs'


