#!/bin/bash
set -e

echo "Executing $0"

echo "------------------"
echo " Clearing cache..."
echo "------------------"
rm -rf /var/lib/apt/lists/*

echo "----------------------"
echo " Cleanup after salt..."
echo "----------------------"
rm -rf /srv
rm -rf /etc/salt/pki
rm -rf /etc/salt/minion_id
rm -rf /etc/salt/minion
rm -rf /var/cache/salt
rm -rf /var/log/salt
rm -rf /tmp/salt/*
