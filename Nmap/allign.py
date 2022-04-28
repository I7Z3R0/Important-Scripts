#!/usr/bin/env python3

import re
import sys


def ports(nmap):
    column = ""
    with open(nmap, "r") as searchfile:
        for line in searchfile:
            if '/tcp' in line:
                first_column = re.findall("(.*)/tcp", line)
                final = "".join(first_column)
                if final.isnumeric():
                	column += "," + final
                else:
                	continue
    column = column[1:]
    print(column)

if __name__ == '__main__':
    if len(sys.argv[1:]) < 1:
        print('''
        Usage : python3 script.py <file name>

        Example : python3 script.py nmap/all.nmap
            ''')
    else:
        nmap = sys.argv[1].strip()
        ports(nmap)
