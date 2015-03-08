#!/bin/bash

# Check if we are running as root
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

apt-get update
apt-get upgrade
apt-get autoremove
apt-get autoclean
