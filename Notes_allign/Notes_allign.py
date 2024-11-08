#!/usr/bin/env python3

import re
import sys
import subprocess

def ports(nmap):
    column = ""  # Initialize `column` here to store all formatted output
    with open(nmap, "r") as searchfile:
        for line in searchfile:
            if '/tcp' in line:
                # Extract the port number and service name
                port_number = re.findall(r"(\d+)/tcp", line)
                service_name = re.findall(r"open\s+(\S+)", line)
                
                # Check if both port and service were found
                if port_number and service_name:
                    # Format the output as "<port>-<service> -\n"
                    formatted_output = f"{port_number[0]}-{service_name[0].upper()} -\n"
                    column += formatted_output  # Append each formatted line to `column`
                    sys.stdout.write(formatted_output)  # Print each line as you go

    # Copy the final result to the clipboard
    subprocess.run(f"echo -n '{column}' | xclip -selection clipboard", shell=True, check=True)
    print("\nThe list of ports has been copied to the clipboard.")

if __name__ == '__main__':
    if len(sys.argv[1:]) < 1:
        print('''
        Usage : python3 script.py <file name>

        Example : python3 script.py nmap/all.nmap
            ''')
    else:
        nmap = sys.argv[1].strip()
        ports(nmap)
