#!/bin/bash
set -e

echo "Executing $0"

echo "-------------------"
echo " Updating ubuntu..."
echo "-------------------"
apt-get update
apt-get --yes upgrade

echo "---------------------------"
echo " Installing dependencies..."
echo "---------------------------"
apt-get --yes install \
  git \
  gnupg \
  vim \
  wget

echo "---------------------"
echo " Install salt repo..."
echo "---------------------"
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list

echo "-----------------------"
echo " Install salt-minion..."
echo "-----------------------"
apt-get update
apt-get --yes install salt-minion
