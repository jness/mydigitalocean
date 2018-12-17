#!/bin/bash

echo "Executing $0"

# get latest distribution packages
echo "Updating ubuntu..."
apt-get update
apt-get -y upgrade

# install dependencies
echo "Installing dependencies..."
apt-get -y install \
  curl \
  wget \
  vim
