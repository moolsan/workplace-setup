#!/bin/bash

if [ -z (which lsb_release) ]; then
  apt-get --assume-yes install lsb-base
fi

if [ $(lsb_release -si) != "Ubuntu" ]; then
  echo "WARN: this script is only tested under Ubuntu!"
fi

wget -O /tmp/puppetlabs-release-$(lsb_release -sc).deb http://apt.puppetlabs.com/puppetlabs-release-$(lsb_release -sc).deb
dpkg -i /tmp/puppetlabs-release-$(lsb_release -sc).deb
apt-get update
apt-get --assume-yes install puppet

puppet module install maestrodev-wget
