# Script used to allign the nmap ports from the nmap scan results

```bash
Make sure to put this script in PATH

➜  Documents mv allign.py ~/.local/bin/allign
➜  Documents chmod +x ~/.local/bin/allign 


```

## Usage

      Usage : python3 script.py <file name>
      Example : python3 script.py nmap/all.nmap
      
## POC

```bash
➜  attacktive_directory python stage3.py nmap/full.nmap 
53,80,88,135,139,389,445,464,593,636,3268,3269,3389,5985,9389,47001,49664,49665,49667,49669,49672,49673,49674,49678,49684,49695,49814 
```
