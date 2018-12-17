#!/bin/bash

echo "Executing $0"

# get latest distribution packages
echo "-------------------"
echo " Updating ubuntu..."
echo "-------------------"
apt-get update
apt-get -y upgrade

# install dependencies
echo "---------------------------"
echo " Installing dependencies..."
echo "---------------------------"
apt-get -y install \
  curl \
  wget \
  vim

# install ansible
echo "----------------------"
echo " Installing ansible..."
echo "----------------------"
apt-get -y install ansible
