# dsys-maintenance

## 🛠️ **System Maintenance & Health Check Script**
**Version:** 1.5.0-0706202522
**Platform:** Debian/Ubuntu Linux

### 🔍 **Overview**

This Bash script is a comprehensive, all-in-one system maintenance and diagnostic tool tailored for Debian-based Linux systems. It automates essential maintenance tasks while presenting real-time system information in a clean, structured, and user-friendly format.

---

### ✨ **Key Features**

#### 📊 System Info & Monitoring

* Displays OS, kernel, hostname, uptime, and load average
* Shows CPU, memory, and storage usage
* Retrieves laptop battery status (ACPI/UPower compatible)
* Lists top memory and CPU consuming processes

#### ⚙️ System Maintenance

* Updates and upgrades system packages
* Fixes broken dependencies
* Cleans apt cache, orphaned packages, and logs
* Calculates disk space freed after cleanup
* Tracks and formats execution time (`hh:mm:ss`)

#### 🔐 Security & Health

* Checks available security updates (`unattended-upgrades`)
* Displays failed services (`systemctl --failed`)
* Verifies disk SMART health status (auto-detects drives)
* Tests internet connection speed (`speedtest-cli`)
* Displays firewall status (UFW or iptables)

#### 📦 Package & Backup Support

* Lists recently installed and upgraded packages
* Backs up essential config files from `/etc`

#### 📌 Presentation & User Experience

* Step-by-step progress display with task tracking
* Clean log file with section headers and timestamps
* Elegant dividers and boxed headers for readability
* Interactive reboot prompt if required

---

### 📂 **Output**

All actions and summaries are saved to a timestamped log file for easy reference and troubleshooting.

Instructions
-------------
1. Save it to workspace, e.g., dsys-maintenance.sh
2. Make it executable by chmod +x dsys-maintenance.sh
3. Run it by ./dsys-maintenance.sh
4. Log are generated with folder SYSM
