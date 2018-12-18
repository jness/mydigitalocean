#!/bin/bash

echo "Executing $0"

# get latest distribution packages
echo "-------------------"
echo " Updating ubuntu..."
echo "-------------------"
apt-get update
apt-get --yes upgrade

# install dependencies
echo "-----------------------"
echo " Installing packages..."
echo "-----------------------"
apt-get --yes install \
  curl \
  wget \
  vim \
  git \
  software-properties-common

# install dependencies
echo "----------------------"
echo " Installing ansible..."
echo "----------------------"
apt-add-repository --yes --update ppa:ansible/ansible
apt-get update
apt-get --yes install ansible
