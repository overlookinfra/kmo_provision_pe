#!/usr/bin/env sh

set -x

# Install dependencies
sudo dnf update -y

#Upgrade dependencies
sudo dnf upgrade -y

# Move the installer to $HOME
target_dir="$HOME/peinstaller"
mkdir $target_dir
mv /tmp/resources/ $target_dir

#Set permissions on the installer
chmod -R 755 $target_dir

# Run the installer script
$target_dir/resources/scripts/installer.sh

# Clean up after ourselves
rm -rf $target_dir/scripts