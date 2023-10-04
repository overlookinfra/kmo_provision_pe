#!/usr/bin/env sh

set -x

# Move the installer to $HOME to satisfy Bolt
target_dir="$HOME/pe_2021_install"
mkdir $target_dir
rsync --recursive /tmp/resources/ $target_dir

# Run the installer script
$target_dir/scripts/installer.sh

# Clean up after ourselves
rm -rf $target_dir/scripts