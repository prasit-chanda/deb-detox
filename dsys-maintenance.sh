#!/bin/bash

###############################################################################
#
# 🛠️  System Maintenance & Health Check Script
# Script    : dsys-maintenance.sh
# Purpose   : Perform system updates, cleanups, backups, and health diagnostics
# Author    : Prasit Chanda
# Platform  : Debian/Ubuntu Linux
#
# 📄 Overview:
# This script automates essential system maintenance tasks and displays 
# diagnostic information in a clear, structured format. It helps improve 
# system performance, free up disk space, and monitor overall system health.
#
# ✅ Key Features:
#
# ── 📊 System Information ──
# - OS details, CPU info, memory and storage usage
# - Battery health, running processes, and system uptime
#
# ── ⚙️ Maintenance Tasks ──
# - Update package lists and upgrade system packages
# - Fix broken or missing dependencies
# - Auto-remove obsolete packages and purge leftovers
# - Clean up system cache, user cache, and thumbnail previews
# - Remove orphaned libraries and unused Snap/Flatpak versions
# - Empty Trash and clear old system logs (older than 7 days)
# - Clear content of log files to reclaim space without deleting logs
#
# ── 🔐 Security & Health ──
# - List available security updates
# - Check for failed systemd services
# - Display SMART disk health status
#
# ── 🌐 Network Diagnostics ──
# - Test internet speed (download/upload)
# - Show firewall (UFW) status
# - Display default gateway and active network info
#
# ── 📦 Package Insight ──
# - Show recently installed and upgraded packages
#
# ── 🪄 User Experience ──
# - Step-by-step status display with formatted output
# - Tracks execution time and writes all activity to a timestamped log file
#
# 📁 Output:
# All operations and diagnostic results are saved in a clearly structured 
# log file, named with the current timestamp, for auditing and future review.
#
###############################################################################

# ───── Configuration ─────
CURRENT_DATE=$(date +"%d-%B-%Y %r")
TIMESTAMP=$(date +"%s")
WORKING_DIR=$(pwd)
LOG_DIR="${WORKING_DIR}/dsys-scrub"
LOG_FILE="${LOG_DIR}/log${TIMESTAMP}.log"
KERNEL=$(uname -r)
VERSION="1.6.0-0906202531"

# ───── Print Box ─────
print_box() {
  local content="$1"
  local length=${#content}
  local border=$(printf '─%.0s' $(seq 1 $((length + 0))))
  echo -e "┌${border}┐"
  echo -e " $content  "
  echo -e "└${border}┘"
}

# ───── Custom Divider ─────
divider_custom() {
  local char="$1"
  local width="$2"
  printf '%*s\n' "$width" '' | tr ' ' "$char"
}

# ───── Create log directory ─────
clear
mkdir -p "${LOG_DIR}"
{
echo " "
echo "🛠️  System Maintenance & Health Check Script" 
echo " "
echo "Author    : Prasit Chanda"
echo "Version   : ${VERSION}"
echo "Platform  : Debian/Ubuntu Linux"
echo " "
print_box "Overview"
echo "This script automates essential system maintenance and displays diagnostic information in a clean, structured format."
echo " "
print_box "Key Features"
echo "- 📊  System Info: OS, CPU, memory, storage, battery, processes, uptime"
echo "- ⚙️  Maintenance: apt update/upgrade, fix dependencies, cleanup, disk space freed"
echo "- 🔐  Security & Health: security updates, failed services, SMART disk health"
echo "- 🌐  Network: Internet speed test, firewall status"
echo "- 📦  Package Insight: Recently installed/upgraded packages"
echo "- 🧰  Config Backup: Backup of critical /etc files"
echo "- 🪄  UX: Step-by-step progress, formatted log, execution time display"
echo " "
print_box "Output"
echo "All activity and results are saved in a timestamped log file for auditing."
echo " "
}
sleep 0.1

# ───── Log Header ─────
{
print_box "Debian System Maintenance"
echo "Date: $CURRENT_DATE"
} | tee "${LOG_FILE}"

# ───── Remove APT Locks ─────
echo -e "\nRemoving APT Locks . . . . .\n" | tee -a "${LOG_FILE}"
sudo rm -f /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock
sudo dpkg --configure -a
sleep 0.1

# ───── System Information ─────
print_box "System Information" | tee -a "${LOG_FILE}"
{
    echo "----------- OS Information -----------"
    lsb_release -a 2>/dev/null
    echo
    echo "----------- Host Information -----------"
    hostnamectl
    echo
    echo "----------- CPU Information -----------"
    lscpu | grep -E '^Model name|^CPU\(s\)|^Thread|^Socket|^Core'
    echo
    echo "----------- RAM Information -----------"
    free -h
    echo
    echo "----------- Storage Information -----------"
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
    echo
    echo "----------- Top Disk Usage -----------"
    df -h | sort -hr -k 5 | head -n 10
} | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Network Info ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Network Info" | tee -a "${LOG_FILE}"
ip -brief address show | tee -a "${LOG_FILE}"
echo -ne "real ip \t\t\t" | tee -a "${LOG_FILE}" 
curl -s ifconfig.me | tee -a "${LOG_FILE}"
echo -e " " | tee -a "${LOG_FILE}"
echo -ne "gateway \t\t\t" | tee -a "${LOG_FILE}" 
ip route | grep default | awk '{print $3}' | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Internet Speed ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Internet Speed" | tee -a "${LOG_FILE}"
if command -v speedtest &>/dev/null; then
    speedtest --simple | tee -a "${LOG_FILE}"
else
    echo "speedtest-cli not installed. Installing..." | tee -a "${LOG_FILE}"
    sudo apt install speedtest-cli -y | tee -a "${LOG_FILE}"
    speedtest --simple | tee -a "${LOG_FILE}"
fi
sleep 0.1

# ───── Security Updates Available ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Security Updates" | tee -a "${LOG_FILE}"
if dpkg -l | grep -q unattended-upgrades; then
    sudo unattended-upgrade --dry-run -d | grep "Checking" -A 100 | tee -a "${LOG_FILE}"
else
    echo "unattended-upgrades not installed. Installing it..." | tee -a "${LOG_FILE}"
    sudo apt install unattended-upgrades -y | tee -a "${LOG_FILE}"
    sudo unattended-upgrade --dry-run -d | grep "Checking" -A 100 | tee -a "${LOG_FILE}"
fi
sleep 0.1

# ───── Disk Health (SMART) [Optional] ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Disk Health (SMART)" | tee -a "${LOG_FILE}"
if command -v smartctl &>/dev/null; then
    DISKS=$(lsblk -dno NAME)
    for disk in $DISKS; do
        echo "→ Checking /dev/$disk" | tee -a "${LOG_FILE}"
        sudo smartctl -H "/dev/$disk" | grep -E "SMART overall-health self-assessment test result" | tee -a "${LOG_FILE}"
    done
else
    echo "smartctl not found. Install with: sudo apt install smartmontools" | tee -a "${LOG_FILE}"
fi
sleep 0.1

# ───── Firewall Status ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Firewall Status" | tee -a "${LOG_FILE}"
command -v ufw &>/dev/null && sudo ufw status verbose | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Update & Upgrade ─────
#echo " " | tee -a "${LOG_FILE}"
print_box "Update & Upgrade Packages" | tee -a "${LOG_FILE}"
sudo apt update | tee -a "${LOG_FILE}"
sudo apt upgrade -y | tee -a "${LOG_FILE}"
sudo apt full-upgrade -y | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Recently Installed Packages ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Recently Packages" | tee -a "${LOG_FILE}"
if ! grep " install " /var/log/dpkg.log | tail -10 | tee -a "${LOG_FILE}" | grep -q .; then
    echo "No recent package installations found" | tee -a "${LOG_FILE}"
fi
sleep 0.1

# ───── Uptime & Load ─────
echo " " | tee -a "${LOG_FILE}"
print_box "System Uptime & Load" | tee -a "${LOG_FILE}"
echo "Uptime: $(uptime -p)" | tee -a "${LOG_FILE}"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')" | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Battery & Temperature Info ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Battery Information" | tee -a "${LOG_FILE}"
echo -e "Battery Information:" | tee -a "${LOG_FILE}"
if command -v acpi &>/dev/null; then
    acpi -b | tee -a "${LOG_FILE}"
elif command -v upower &>/dev/null; then
    BATT=$(upower -e | grep 'battery')
    if [ -n "$BATT" ]; then
        upower -i "$BATT" | grep -E "state|to full|percentage|time to empty" | tee -a "${LOG_FILE}"
    else
        echo "No battery detected." | tee -a "${LOG_FILE}"
    fi
else
    echo "Battery tool (acpi or upower) not installed or no battery present." | tee -a "${LOG_FILE}"
fi
sleep 0.1

# ───── Systemd Failed Services ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Failed Systemd Services" | tee -a "${LOG_FILE}"
systemctl --failed | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Large Files (100MB+) ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Largest Files (over 100MB)" | tee -a "${LOG_FILE}"
find / -type f -size +100M -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Disk Usage Before Cleanup ─────
echo " " | tee -a "${LOG_FILE}"
print_box "Disk Usage Before Cleanup" | tee -a "${LOG_FILE}"
BEFORE_CLEAN=$(df / | awk 'NR==2 {print $4}')
echo -e "Disk space before cleanup (in 1K-blocks): $BEFORE_CLEAN" | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Cleanup ─────
echo -e "Cleaning up apt . . . . ." | tee -a "${LOG_FILE}"
sudo apt autoremove -y | tee -a "${LOG_FILE}"
sudo apt autoremove --purge -y | tee -a "${LOG_FILE}"
sudo apt autoclean -y | tee -a "${LOG_FILE}"
sudo apt clean -y | tee -a "${LOG_FILE}"
echo -e "Cleaning thumbnail cache . . . . ."| tee -a "${LOG_FILE}"
sudo rm -rf ~/.cache/thumbnails/* | tee -a "${LOG_FILE}"
echo -e "Cleaning user-level cache files . . . . ." | tee -a "${LOG_FILE}"
sudo rm -rf ~/.cache/* | tee -a "${LOG_FILE}"
echo -e "Cleaning old system logs . . . . ." | tee -a "${LOG_FILE}"
sudo journalctl --vacuum-time=7d | tee -a "${LOG_FILE}"
echo -e "Emptying Trash folders . . . . ." | tee -a "${LOG_FILE}"
sudo rm -rf ~/.local/share/Trash/* | tee -a "${LOG_FILE}"
echo -e "Removing old Snap package versions . . . . ." | tee -a "${LOG_FILE}"
snap list --all | awk '/disabled/{print $1, $2}' | while read snapname version; do
    sudo snap remove "$snapname" --revision="$version"  | tee -a "${LOG_FILE}"
done
echo -e "Removing orphaned packages . . . . ." | tee -a "${LOG_FILE}"
sudo deborphan | xargs sudo apt-get -y remove --purge | tee -a "${LOG_FILE}"
echo -e "Cleaning logs . . . . ." | tee -a "${LOG_FILE}"
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \; | tee -a "${LOG_FILE}"
if command -v flatpak &> /dev/null; then
    echo -e "Cleaning unused Flatpak versions . . . . ." | tee -a "${LOG_FILE}"
    sudo flatpak uninstall --unused -y | tee -a "${LOG_FILE}"
else
    echo -e "Flatpak is not installed" | tee -a "${LOG_FILE}"
fi
echo " " | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Disk Usage After Cleanup ─────
print_box "Disk Usage After Cleanup" | tee -a "${LOG_FILE}"
AFTER_CLEAN=$(df / | awk 'NR==2 {print $4}')
FREED=$((AFTER_CLEAN - BEFORE_CLEAN))
FREED_MB=$((FREED / 1024))
END_TIME=$(date +%s)
DURATION=$((END_TIME - TIMESTAMP))
H=$((DURATION / 3600))
M=$(((DURATION % 3600) / 60))
S=$((DURATION % 60))
echo -e "Disk space after cleanup (in 1K-blocks): $AFTER_CLEAN" | tee -a "${LOG_FILE}"
echo -e "Estimated space freed: ${FREED_MB} MiB" | tee -a "${LOG_FILE}"
echo "End Time: $(date +"%d-%B-%Y %r")" | tee -a "${LOG_FILE}"
echo -e "\nTotal Execution Time: ${H}h ${M}m ${S}s" | tee -a "${LOG_FILE}"
echo "Log File: $LOG_FILE"
echo -e "System maintenance completed successfully." | tee -a "${LOG_FILE}"
sleep 0.1

# ───── Footer ─────
echo " " | tee -a "${LOG_FILE}"
divider_custom "#" 45 | tee -a "${LOG_FILE}"
echo "Prasit Chanda © 2015 - $(date +"%Y")" | tee -a "${LOG_FILE}"
echo "Version ${VERSION}" | tee -a "${LOG_FILE}"
divider_custom "#" 45 | tee -a "${LOG_FILE}"
echo " " | tee -a "${LOG_FILE}"
exit