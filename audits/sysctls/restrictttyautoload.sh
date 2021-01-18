#!/bin/bash

printf "TTY line disciplines convert the TTY to signals that hardware can\n";
printf "understand. By default, most Linux distributions allow the loading\n";
printf "of these line disciplines. However, this allows attackers to load\n";
printf "vulnerable ones with the TIOCSETD ioctl (and has been done before)\n";
printf "which can give attackers root privileges.\n\n";

printf "Would you like to harden TTY Line Disciplines? [Y/n]: "
read -r SECLEVEL

# If user inputted Y, we append dev.tty.ldisc_autoload=0 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we append dev.tty.ldisc_autoload=0
		sed -i '/dev.tty.ldisc_autoload*/d' /etc/sysctl.conf;
		echo "dev.tty.ldisc_autoload=0" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "n" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/dev.tty.ldisc_autoload*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
