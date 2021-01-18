#!/bin/bash

printf "The Berkeley Packet Filter (eBPF) is known for providing a large\n";
printf "attack surface, meaning that it is wise to restrict eBPF to the\n";
printf "CAP_BPF capability set. On top of this, it is wise to enable JIT\n";
printf "hardening features (to enable the hiding of certain contents in\n";
printf "memory to protect against attacks like JIT spraying).\n\n";

printf "Would you like to enable this feature? [Y/n]: "

read -r SECLEVEL

# If user inputted Y, we append kernel.unprivileged_bpf_disabled=1 and
# net.core.bpf_jit_harden=2 to /etc/sysctl.conf.
# If user inputted n, we exit this script.

while true
do
	if [ "$SECLEVEL" == "Y" ]
	then
		# Since user inputted "Y" we disable unprivileged bpf
		# and enable bpf jit hardening
		sed -i '/kernel.unprivileged_bpf_disabled*/d' /etc/sysctl.conf;
		sed -i '/net.core.bpf_jit_harden*/d' /etc/sysctl.conf;
		echo "kernel.unprivileged_bpf_disabled=1" >> /etc/sysctl.conf;
		echo "net.core.bpf_jit_harden=2" >> /etc/sysctl.conf;
		exit 0;
	elif [ "$SECLEVEL" == "n" ]
	then
		# Since user inputted "N" we ensure this option doesn't exist
		# in /etc/sysctl.conf and exit.
		sed -i '/kernel.unprivileged_bpf_disabled*/d' /etc/sysctl.conf;
		sed -i '/net.core.bpf_jit_harden*/d' /etc/sysctl.conf;
		exit 0;
	else
		# Error Catching
		printf "Enter Y for yes or n for no: "
		read -r SECLEVEL;
	fi
done
