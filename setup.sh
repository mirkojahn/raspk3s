#!/bin/bash

##############################################################
# Attention! 
#
# This script requires super user priviledges for some tasks!
#

# First disable IPv6, because it tend to cause issues with k3s
grep -q '^net.ipv6.conf.all.disable_ipv6' /etc/sysctl.conf \
        && sudo sed -i 's/^net.ipv6.conf.all.disable_ipv6.*/net.ipv6.conf.all.disable_ipv6 = 1/' /etc/sysctl.conf \
        || sudo echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
# Apply the changes
sudo sysctl -p

# The system should always be up-to-date (I don't care about short outages or a broken system atm)
sudo apt-get install unattended-upgrades -y

# Install k3s.io, but with a different write config mode
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

kubectl top node