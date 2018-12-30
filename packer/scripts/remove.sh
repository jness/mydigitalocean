#!/bin/bash
set -e

echo "Executing $0"

echo "---------------"
echo " Remove salt..."
echo "---------------"
apt-get --yes remove \
  salt-master \
  salt-minion \
  salt-ssh \
  salt-syndic \
  salt-cloud \
  salt-api

echo "--------------------------"
echo " Remove unused packages..."
echo "--------------------------"
apt-get --yes purge
apt-get --yes autoremove
apt-get --yes autoclean
