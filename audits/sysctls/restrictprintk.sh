#!/bin/bash

printf "Even if dmesg is hardened, the kernel log may still display info\n";
printf "while the system is booting. Software that can record the screen\n";
printf "during bootup could use this information to gain access without\n";
printf "authorization.\n\n";

printf "Would you like to harden the kernel log? [Y/n]: "

read -r SECLEVEL

# If user inputted Y, we append kernel.printk=3 3 3 3 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we append kernel.printk=3 3 3 3
		sed -i '/kernel.printk=*/d' /etc/sysctl.conf;
		echo "kernel.printk=3 3 3 3" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "n" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.printk=*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
