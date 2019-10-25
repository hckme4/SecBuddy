#!/bin/bash

# This script introduces automation of updates to this Gentoo device.
# Note that to achieve fully automated updates, an expect script will
# be necessary, and is NOT RECOMMENDED for Gentoo. It is built from
# source, and low-level changes won't always work across the board.

# Print a warning to the user and grab user input.
printf "APT UPDATE\nRun This As Root!!!\n-----------------------------------------\n";
printf "\nWARNING: Updating Debian-based systems can result in unexpected behavior.\n";
printf "Are you sure you want to continue? [Y/n]: ";

read -r RUN_INSTALL

# If the user typed "Y" we begin re-emerging packages and recompiling them.
# If the user typed "n" we exit the program.
# Script does not exit unless ctrl-C'ed or expected input is recieved.

while true
do
	if [ "$RUN_INSTALL" == "Y" ]
	then
		# Since user inputted "Y", we begin the update process.

		apt-get -y update
		apt-get -y upgrade
		apt-get -y dist-upgrade

		exit 0;
	elif [ "$RUN_INSTALL" == "n" ]
	then
		# Since user inputs "n" to get here, we print a message telling user we are quitting
		# the script, and we do.
		printf "Not updating upon user request. Exiting.......\n\n"
		exit 0;
	else
		# If here, user inputted something wrong, so lets make sure they provide proper input.
		printf "Enter a capital Y for yes, lowercase n for no: "
		read -r RUN_INSTALL
	fi
done
