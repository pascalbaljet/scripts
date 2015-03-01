#!/bin/bash

# Check if we are running as root
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

# Delete old backups
rm -rf /var/opt/gitlab/backups/*

# Create backup
gitlab-rake gitlab:backup:create

# Untar the backup and delete the tar file
cd /var/opt/gitlab/backups
tar -xvf *.tar
rm /var/opt/gitlab/backups/*.tar
