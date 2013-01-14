#!/bin/bash
#
# Install dependencies for kernel development
# This script requires put a SSH private key (id_rsa) to the same directory of
# the Vagrantfile.
#
# Copyright 2012 (c) Lei Xu <eddyxu@gmail.com>

set -e

apt-get install -y -qq software-properties-common
add-apt-repository -y ppa:git-core/ppa
apt-get update -qq
apt-get dist-upgrade -y -qq
apt-get install -y -qq git-core vim ctags cscope fakeroot build-essential crash \
	kexec-tools makedumpfile kernel-wedge libncurses5 libncurses5-dev \
	libelf-dev asciidoc binutils-dev tmux curl
apt-get clean -qq

sudo -u vagrant cp /vagrant/id_rsa /home/vagrant/.ssh
