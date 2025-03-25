
---

# **Linux Privilege Escalation Enumeration Script**

## **📌 Overview**
This script automates the process of **enumerating potential privilege escalation vectors** on Linux systems. It collects system information, checks misconfigurations, searches for exploitable files, and identifies potential security weaknesses that attackers might use to gain elevated privileges.

The script is useful for **penetration testers, security researchers, and system administrators** to assess and secure Linux systems against privilege escalation threats.

---

## **⚡ Features**
🔹 Identifies **current user privileges** and sudo permissions.  
🔹 Checks for **SUID/SGID binaries** that can be exploited.  
🔹 Searches for **writable files/directories** that could be misused.  
🔹 Lists **root-owned cron jobs** that might be vulnerable.  
🔹 Checks for **misconfigured environment variables** (e.g., `$PATH`).  
🔹 Identifies **open ports and listening services**.  
🔹 Finds **SSH private keys** left on the system.  
🔹 Detects **Docker misconfigurations** that may allow privilege escalation.  
🔹 Examines **NFS shares**, **writable systemd services**, and **running processes as root**.  

---

## **📌 How It Works**
The script runs multiple Linux commands to collect and display potential privilege escalation paths. It categorizes findings into sections, making it easier to analyze security risks.

### **Example Output:**
```bash
============================================
  Linux Privilege Escalation Enumeration
============================================

[+] Current User: user123
[+] User ID: uid=1001(user123) gid=1001(user123) groups=1001(user123), sudo

[+] Kernel Version:
5.15.0-84-generic

[+] Checking Sudo Permissions:
(ALL) NOPASSWD: /bin/bash

[+] Searching for SUID Files:
-rwsr-xr-x 1 root root 54248 Jan 18 2018 /usr/bin/passwd

[+] Checking Open Ports:
tcp   LISTEN 0 0 0.0.0.0:22    0.0.0.0:*   LISTEN   1323/sshd
```

---

## **🚀 Installation & Usage**
### **1️⃣ Download the Script**
Clone the repository:
```bash
git clone https://github.com/ahadiii786/Linux-Privilege-Escalation-Enumeration.git
cd Linux-Privilege-Escalation-Enumeration
```
or manually download `enum.sh` from the repository.

### **2️⃣ Grant Execution Permissions**
Before running the script, give it execute permissions:
```bash
chmod +x enum.sh
```

### **3️⃣ Run the Script**
Execute the script with:
```bash
./enum.sh
```

⚠️ **Note:** Some sections of the script require **sudo privileges** for full execution. Run it as root for best results:
```bash
sudo ./enum.sh
```

---

## **🛠️ Requirements**
- **Linux OS:** Works on most distributions (Ubuntu, Debian, CentOS, Arch, etc.).
- **Bash Shell:** The script is written in Bash.
- **Basic Commands:** Requires `find`, `ls`, `cat`, `netstat`, `systemctl`, `sudo`, `docker`, etc.
- **Root Access (Optional):** Some checks may require root access.

---

## **🔍 Comparison with linPEAS**
This script focuses on **basic privilege escalation checks** and is **lightweight**, whereas **linPEAS** is a **more advanced** and **extensive** tool that:
✔ Uses **color-coded outputs** to highlight risky findings.  
✔ Scans for **Kernel exploits** and **LXC misconfigurations**.  
✔ Searches for **passwords in files** and environment variables.  
✔ Checks **installed software for known vulnerabilities**.  
✔ Provides **recommendations for exploits**.  

**💡 Recommendation:** If you need a quick and simple check, this script is great. However, for **detailed** analysis, **linPEAS is more comprehensive**.

---

## **⚠️ Disclaimer**
This script is **for educational and security assessment purposes only**. Do **not** use it on unauthorized systems. The author is **not responsible** for any misuse.

---

## **📜 License**
This project is licensed under the **MIT License** – you are free to use, modify, and distribute it as long as you include this notice.

---

## **📞 Contact & Contributions**
🔹 Found an issue or have suggestions? Open a **GitHub Issue**.  
🔹 Want to contribute? Fork the repo and submit a Pull Request.  
🔹 Need help? Reach out at mhdahadsiddique@gmail.com  

---
