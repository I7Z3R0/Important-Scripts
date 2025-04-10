#!/bin/bash

echo "Enter the target IP Address : "
read target_ip
mkdir -p nmap www exploit research autorecon templates
cp /opt/priv/linpeas/linpeas.sh www
cp /opt/priv/lse/lse.sh www
cp /opt/priv/pspy/pspy64 www
cp /opt/priv/pspy/pspy32 www
cp /usr/share/seclists/Web-Shells/laudanum-1.0/php/php-reverse-shell.php www
if [ ! -e notes.md ]; then
    touch notes.md
    ip_tun0=$(sh -c 'ip a | awk "/tun0\$/{gsub(/\/.*/, \"\"); print \$2}"')
    echo -e "MY IP = $ip_tun0" >> notes.md
    echo -e "Target = $target_ip" >> notes.md
    echo -e "$target_ip" > /target/target
    reverse -p 9001 >> research/rev.out
    subl $(pwd)
fi


TEMPLATE_PATH=/home/kali/Desktop/_templates/template.ctd
CT_FILE=templates/notes.ctd

if [ -f "$TEMPLATE_PATH" ]; then
    cp "$TEMPLATE_PATH" "$CT_FILE"
    setsid cherrytree -S "$CT_FILE" > /dev/null 2>&1 < /dev/null &
else
    echo "Template not found at $TEMPLATE_PATH"
fi
