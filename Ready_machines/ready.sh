#!/bin/bash

echo "Enter the target IP Address : "
read target_ip
mkdir -p nmap www exploit research
if [ ! -e notes.md ]; then
    touch notes.md
    ip_tun0=$(sh -c 'ip a | awk "/tun0\$/{gsub(/\/.*/, \"\"); print \$2}"')
    echo -e "MY IP = $ip_tun0" >> notes.md
    echo -e "Target = $target_ip" >> notes.md
    echo -e "$target_ip" > /target/target
    subl notes.md
fi
