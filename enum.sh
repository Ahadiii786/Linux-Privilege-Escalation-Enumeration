#!/bin/bash

# Define colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================"
echo -e "  Linux Privilege Escalation Enumeration  "
echo -e "============================================${NC}"

# Check current user
echo -e "\n${GREEN}[+] Current User:${NC} $(whoami)"
echo -e "${GREEN}[+] User ID:${NC} $(id)"

# System Information
echo -e "\n${YELLOW}[+] System Information:${NC}"
uname -a
cat /etc/os-release 2>/dev/null

# Kernel Version
echo -e "\n${YELLOW}[+] Kernel Version:${NC}"
KERNEL=$(uname -r)
echo "$KERNEL"

# Suggest kernel exploits from ExploitDB
echo -e "\n${RED}[HIGH] Checking for Known Kernel Exploits:${NC}"
curl -s "https://raw.githubusercontent.com/offensive-security/exploitdb/master/files_exploits.csv" | grep "$KERNEL" | awk -F, '{print "Exploit:", $2, "\nURL: https://www.exploit-db.com/exploits/" $1}' || echo "No known exploits found."

# Sudo Permissions
echo -e "\n${YELLOW}[+] Checking Sudo Permissions:${NC}"
sudo -l 2>/dev/null

# Checking if the user is in the sudoers group
echo -e "\n${YELLOW}[+] Checking if user has sudo rights:${NC}"
groups | grep "sudo" && echo -e "${RED}[HIGH] User is in sudo group!${NC}"

# SUID Files
echo -e "\n${YELLOW}[+] Searching for SUID Files:${NC}"
find / -perm -4000 -type f 2>/dev/null | tee suid_files.txt
echo -e "\n${RED}[HIGH] Checking for SUID exploits:${NC}"
while IFS= read -r line; do
    grep -i "$(basename "$line")" /usr/share/exploitdb/files_exploits.csv 2>/dev/null
done < suid_files.txt

# World-Writable Files
echo -e "\n${YELLOW}[+] Searching for World-Writable Files:${NC}"
find / -type f -perm -2 -ls 2>/dev/null | head -n 10

# Writable Systemd Services
echo -e "\n${YELLOW}[+] Searching for Writable Systemd Services:${NC}"
find /etc/systemd/system/ -type f -perm -2 2>/dev/null

# Root-Owned Cron Jobs
echo -e "\n${YELLOW}[+] Checking for Root-Owned Cron Jobs:${NC}"
cat /etc/crontab 2>/dev/null
ls -la /etc/cron.d/ 2>/dev/null
ls -la /var/spool/cron/crontabs/ 2>/dev/null

# Writable /etc/passwd and /etc/shadow
echo -e "\n${YELLOW}[+] Checking if /etc/passwd and /etc/shadow are Writable:${NC}"
ls -la /etc/passwd 2>/dev/null
ls -la /etc/shadow 2>/dev/null

# PATH Variable Exploitation
echo -e "\n${YELLOW}[+] Checking PATH Variable for Exploitable Entries:${NC}"
echo $PATH | grep -E '(^|:)(\.|/tmp|/dev/shm)(:|$)' && echo -e "${RED}[HIGH] Unsafe PATH variable detected!${NC}"

# Running Services
echo -e "\n${YELLOW}[+] Checking Running Services:${NC}"
systemctl list-units --type=service --state=running 2>/dev/null | head -n 15

# Searching for Passwords in Configuration Files
echo -e "\n${YELLOW}[+] Searching for Passwords in Config Files:${NC}"
grep -i "password" /etc/*.conf /etc/*.ini /root/.*history /home/*/.bash_history 2>/dev/null

# Docker Privileges
echo -e "\n${YELLOW}[+] Checking for Docker Privileges:${NC}"
docker images 2>/dev/null && echo -e "${RED}[HIGH] Docker breakout may be possible!${NC}"

# SSH Private Keys
echo -e "\n${YELLOW}[+] Searching for SSH Private Keys:${NC}"
find / -name "id_rsa" -o -name "id_dsa" 2>/dev/null

# Linux File Capabilities
echo -e "\n${YELLOW}[+] Checking for File Capabilities:${NC}"
getcap -r / 2>/dev/null

# Environment Variables
echo -e "\n${YELLOW}[+] Checking for Suspicious Environment Variables:${NC}"
env | grep -i "path"

# NFS Misconfigurations
echo -e "\n${YELLOW}[+] Checking for NFS Shares:${NC}"
showmount -e 127.0.0.1 2>/dev/null

# Open Ports and Listening Services
echo -e "\n${YELLOW}[+] Checking for Open Ports and Listening Services:${NC}"
ss -tulnp 2>/dev/null | grep LISTEN

# Checking Running Processes as Root
echo -e "\n${YELLOW}[+] Checking for Running Processes as Root:${NC}"
ps aux | grep root | head -n 20

# Log & History Analysis
echo -e "\n${YELLOW}[+] Checking User History for Sensitive Data:${NC}"
cat ~/.bash_history 2>/dev/null | grep -E "password|passwd|secret" && echo -e "${RED}[HIGH] Sensitive history entries found!${NC}"

# Checking Firewall Rules
echo -e "\n${YELLOW}[+] Checking Firewall Rules:${NC}"
iptables -L -n 2>/dev/null

echo -e "\n${BLUE}============================================"
echo -e "  Enumeration Completed. Check Output!  "
echo -e "============================================${NC}"
