 🛠️  System Maintenance & Health Check Script
 
    Script    : debian-detox.sh
    Purpose   : Perform system updates, cleanups, backups, and health diagnostics
    Author    : Prasit Chanda
    Platform  : Debian/Ubuntu Linux

 📄 Overview:
 
    This script automates essential system maintenance tasks and displays diagnostic information 
    in a clear, structured format. It helps improve system performance, free up disk space, and 
    monitor overall system health.

 ✅ Key Features:
 
    ── 📊 System Information ──
        - OS details, CPU info, memory and storage usage
        - Battery health, running processes, and system uptime
    ── ⚙️ Maintenance Tasks ──
        - Update package lists and upgrade system packages
        - Fix broken or missing dependencies
        - Auto-remove obsolete packages and purge leftovers
        - Clean up system cache, user cache, and thumbnail previews
        - Remove orphaned libraries and unused Snap/Flatpak versions
        - Empty Trash and clear old system logs (older than 7 days)
        - Clear content of log files to reclaim space without deleting logs
    ── 🔐 Security & Health ──
        - List available security updates
        - Check for failed systemd services
        - Display SMART disk health status
    ── 🌐 Network Diagnostics ──
        - Test internet speed (download/upload)
        - Show firewall (UFW) status
        - Display default gateway and active network info
    ── 📦 Package Insight ──
        - Show recently installed and upgraded packages
    ── 🪄 User Experience ──
        - Step-by-step status display with formatted output
        - Tracks execution time and writes all activity to a timestamped log file
        
 📁 Output
 
    All operations and diagnostic results are saved in a clearly structured log file, named with 
    the current timestamp, for auditing and future review.

 💡 Instructions

    1. Save it to workspace, e.g., debian-detox.sh
    2. Make it executable by chmod +x debian-detox.sh
    3. Run it by ./debian-detox.sh
    4. Logs are generated within folder debian-detox
