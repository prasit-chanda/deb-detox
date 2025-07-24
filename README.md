# 🛠️ debian-detox.sh — System Maintenance & Health Check Script

**Author**: Prasit Chanda  
**Platform**: Debian / Ubuntu Linux  
**Script Name**: `debian-detox.sh`  

---

## 📌 Purpose

`debian-detox.sh` is a comprehensive system maintenance and diagnostic tool for Debian-based Linux distributions. It automates routine cleanup, optimization, backup, and health-check tasks—helping you keep your system fast, secure, and healthy.

---

## ✨ Features

### 📊 System Overview
- OS version, CPU, memory, and disk usage  
- Battery status, running processes, and uptime

### ⚙️ Maintenance & Cleanup
- Update and upgrade system packages
- Fix broken dependencies  
- Auto-remove obsolete packages  
- Purge residual configurations  
- Clear system/user cache and thumbnail previews  
- Remove orphaned libraries and outdated Snap/Flatpak versions  
- Clean Trash and log files older than 7 days  
- Truncate (not delete) logs to free up space safely

### 🔐 Security & Health Monitoring
- Check for available security updates  
- Detect failed `systemd` services  
- Show SMART disk health status

### 🌐 Network Diagnostics
- Run internet speed tests (download/upload)  
- Display UFW (firewall) status  
- Show active network interface and default gateway

### 📦 Package Insights
- List recently installed and upgraded packages

### 🪄 User Experience
- Step-by-step progress with color-coded output  
- Tracks execution time  
- Logs everything to a timestamped log file

---

## 📁 Output

🗂 All actions and diagnostic results are saved in structured log files under the `debian-detox` directory. Each file is timestamped for easy tracking and auditing.

---

## 🚀 Usage Instructions

1. **Save** the script as `debian-detox.sh`  
2. **Make it executable**:  
   ```bash
   chmod +x debian-detox.sh
   ```
3. **Run it**:  
   ```bash
   ./debian-detox.sh
   ```
4. **Review logs** in the `debian-detox/` directory  

---

## 🧠 Tip

Run `debian-detox.sh` regularly (e.g., weekly) to keep your system running at peak performance.

---

✅ **Tested on:** Ubuntu 20.04+, Debian 11+  
🔒 **Safe & Non-destructive:** All operations are read-only or cleanup tasks. No system settings are changed without your control.

---
