#!/bin/bash

printf "In Linux, dmesg is the kernel log, which exposes lots of information\n";
printf "for debugging the Linux kernel and system. The problem is that this\n";
printf "can leak information such as kernel pointers.\n\n";

printf "Would you like to restrict the kernel log? [Y/n]: "

read -r SECLEVEL

# If user inputted H, we append kernel.kptr_restrict=2 to /etc/sysctl.conf.
# If user inputted M, we append kernel.kptr_restrict=1 to /etc/sysctl.conf.
# If user inputted N, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we append kernel.kptr_restrict=2
		sed -i '/kernel.dmesg_restrict*/d' /etc/sysctl.conf;
		echo "kernel.kptr_restrict=1" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.dmesg_restrict*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes, n for no: "
		read -r SECLEVEL;
	fi
done
