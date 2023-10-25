#!/usr/bin/env sh

set -x

# Install dependencies
sudo dnf update -y

#Upgrade dependencies
sudo dnf upgrade -y

# Add useful support libraries
echo "Installing support libraries"
sudo dnf install -y git curl tree vim

# Prettify Vim
echo "Configuring VIM"
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mv /tmp/resources/files/vimrc ~/.vimrc
chown $USER:$USER ~/.vimrc
git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
git clone https://github.com/rodjek/vim-puppet.git ~/.vim/bundle/vim-puppet
rm -rf /tmp/resources/files/ # Clean up files

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