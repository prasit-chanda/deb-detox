#! /bin/bash

# ───────────────────────────────────────────────────────────────
# Script: system_maintenance.sh
# Purpose: System update, cleanup, and hardware diagnostics
# Author: Prasit Chanda
# Version: 1.1.0-0907201512
# Date: 09 July 2015
# Compatible: Debian-based systems
# ───────────────────────────────────────────────────────────────

#Local Variables
DATE=`date +"%d-%B-%Y %r"`
FILE_DATE=`date +"%s"`
Y=`date +%Y`
WORKING_DIR=`pwd`
LOG_DIR_PATH="${WORKING_DIR}/SYSM"
LOG_FILE_NAME="log"
LOG_FILE_PATH="${LOG_DIR_PATH}/${LOG_FILE_NAME}${FILE_DATE}.txt"
KERNEL=`uname -r`

#Script Strats
clear
#Remove apt-get lock
sudo rm -f /var/lib/dpkg/lock
#Make Log Directory IF NOT EXISTS
mkdir -p ${LOG_DIR_PATH}

#DISPLAY AND WRITE CURRENT DATE TIME
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "Update Starts at ${DATE}"                 | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓                SYSTEM                ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓    INFORMATION    ▓      UPDATE      ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 1 ░     Operating System Details    ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE OS Details
sudo lsb_release -a                             | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE OS KERNEL
echo "OS Kernel: ${KERNEL}"                     | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 2 ░           CPU Details           ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE CPU Details
sudo lscpu                                      | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 3 ░        Hardware Details         ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sudo lshw -short                                | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 4 ░   Overall Packages Statistics   ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Overall Packages Statistics
sudo apt-cache stats                            | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 5 ░   Synchronize Packages Sources  ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Packages Sources Synchronization
sudo apt-fast update                             | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 6 ░   Upgrade Software Packages     ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Packages Upgrade Details
sudo apt-get upgrade                            | tee -a ${LOG_FILE_PATH}
sudo apt-get dist-upgrade                       | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 7 ░  Fixing Packages Dependencies   ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Packages Packages Dependencies Fixings Details
sudo apt-get check                              | tee -a ${LOG_FILE_PATH}
sudo apt-get autoclean                          | tee -a ${LOG_FILE_PATH}
sudo apt-get -f install                         | tee -a ${LOG_FILE_PATH}
sudo dpkg --configure -a                        | tee -a ${LOG_FILE_PATH}
sudo apt-get -f install                         | tee -a ${LOG_FILE_PATH}
sudo apt-get -u dist-upgrade                    | tee -a ${LOG_FILE_PATH}
sudo apt-get -o Debug::pkgProblemResolver=yes dist-upgrade | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 8 ░    Remove Obsolete Packages     ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░░           Cleaning Disk            ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Disk Cleaning Details
sudo apt-get -f autoremove                      | tee -a ${LOG_FILE_PATH}
sudo apt-get -f autoclean                       | tee -a ${LOG_FILE_PATH}
sudo apt-get -f clean                           | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 9 ░          Disk Details           ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Disk Details
sudo lsblk                                      | tee -a ${LOG_FILE_PATH}
sudo fdisk -l                                   | tee -a ${LOG_FILE_PATH}
sudo df -h                                      | tee -a ${LOG_FILE_PATH}

echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓ 1.1.0-09072015-12  ▓  Prasit Chanda  ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓            2015 – ${Y}               ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

DATE=`date +"%d-%B-%Y %r"`
echo "Update Ends at ${DATE}"                   | tee -a ${LOG_FILE_PATH}
exit
#Script Ends
