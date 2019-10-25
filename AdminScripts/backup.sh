#!/bin/bash
# This Script is a simple backup script to quickly tar up important system files and store them in a specific folder.


# Create a little user GUI to assist in the backup process, and read neccessary data into
# variables so we can automate the backup process.

###TUNABLES###############################

TAR_CMD="tar -cvpzf" #Specify Compression Settings. default is tgz. Make sure to preserve permissions when zipping!
BACKUP_LOCATION="/" #Specify Location to create backup folder. Default is /, specify external drive mountpoint here to use.

##########################################

printf "THIS SCRIPT SHOULD BE RUN AS ROOT!\n"
printf "SYSTEM BACKUP\nPlease enter the name of the folder you would like to create: "

read -r BACKUP_FOLDER

echo "OK, Press y to start."
read -r STARTVAR

# Ensure the User presses y to start the backup process, and exit the script when done.
while true
do
	if [ "$STARTVAR" == "y" ]
	then
		# Create backup folder in root directory
		mkdir /"$BACKUP_FOLDER";
		# Generate tar files in backup folder.
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/home.tgz /home;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/etc.tgz /etc;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/bin.tgz /bin;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/sbin.tgz /sbin;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/boot.tgz /boot;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/lib.tgz /lib;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/lib64.tgz /lib64;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/usr.tgz /usr;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/var.tgz /var;
		${TAR_CMD} "$BACKUP_LOCATION""$BACKUP_FOLDER"/sys.tgz /sys;
		exit 0;
	else
		echo "You need to enter y to start the backup.";
		read -r STARTVAR;
	fi
done
