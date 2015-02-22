#!/bin/bash

# Check if we are running as root
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

backup_destination=/media/redbackup/UbuntuServer
user_to_backup=pascalbaljet

echo Backup destination: "$backup_destination"
echo User to backup: "$user_to_backup"

# Create all necessary directories
echo Creating all necessary destination directories
mkdir -p "$backup_destination"/{etc,profile/"$user_to_backup",sources-lists}

# Backup all installed packages
echo Backing up all installed packages...
dpkg --get-selections > $backup_destination/Package.list

# Backup the sources lists
echo Backing up the sources lists...
cp -R /etc/apt/sources.list* $backup_destination/sources-lists/

# Backup an export of all trusted keys
echo Backing up all trusted keys...
apt-key exportall > $backup_destination/Repo.keys

# Sync my homefolder
echo Syncing the homefolder of "$user_to_backup"...
rsync -aAX /home/$user_to_backup $backup_destination/profile

# Sync /etc
echo Syncing the /etc folder
rsync -aAX /etc $backup_destination
