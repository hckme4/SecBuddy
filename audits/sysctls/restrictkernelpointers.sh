#!/bin/bash

printf "A kernel pointer points to a certain area in kernel memory. This can\n";
printf "be useful in exploiting the Linux kernel, and these pointers are not\n";
printf "hidden by default, and can be uncovered through various actions like\n";
printf "looking at the contents of /prock/kallsyms.\n\n"
printf "Enter a security level below [H]igh, [M]edium, [N]one: "

read -r SECLEVEL

# If user inputted H, we append kernel.kptr_restrict=2 to /etc/sysctl.conf.
# If user inputted M, we append kernel.kptr_restrict=1 to /etc/sysctl.conf.
# If user inputted N, we exit this script.

while true
do
	if [ "$SECLEVEL" == "H" ]
	then
		# Since user inputted "H" we append kernel.kptr_restrict=2
		sed -i '/kernel.kptr_restrict*/d' /etc/sysctl.conf;
		echo "kernel.kptr_restrict=2" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "M" ]
	then
		# Since user inputted "M" we append kernel.kptr_restrict=1
		sed -i '/kernel.kptr_restrict*/d' /etc/sysctl.conf;
		echo "kernel.kptr_restrict=1" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "N" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.kptr_restrict*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter H for High Security, M for medium, or N for none: "
		read -r SECLEVEL;
	fi
done
