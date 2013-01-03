#!/bin/bash -
#
# Provision-script for Buildbot servers.
#
# Author Lei Xu <eddyxu@gmail.com>

set -o nounset                              # Treat unset variables as an error
set -e

MASTER_CONFIG=./master-config.sh

apt-get update
apt-get dist-upgrade -y
apt-get install -y python-dev python-pip
pip install buildbot-slave

cd builder

# Install dependencies for building project.
if [ -f ./install-deps.sh ]; then
  ./install-deps.sh
fi

cp -p id_rsa /home/vagrant/.ssh/
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > /home/vagrant/.ssh/config

if [ ! -f $MASTER_CONFIG ]; then
	echo "You need provide file $MASTER_CONFIG"
	exit 1
fi

. $MASTER_CONFIG
sudo -u vagrant buildslave create-slave slave $BB_MASTER $BB_USER $BB_PASS
sudo -u vagrant buildslave restart slave
