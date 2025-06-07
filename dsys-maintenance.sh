#! /bin/bash

# ───────────────────────────────────────────────────────────────
# Script: system_maintenance.sh
# Purpose: System update, cleanup, and hardware diagnostics
# Author: Prasit Chanda
# Version: 1.4.0-1507202211
# Date: 15 July 2022
# Compatible: Debian-based systems
# ───────────────────────────────────────────────────────────────

#Local Variables
DATE=`date +"%d-%B-%Y %r"`
FILE_DATE=`date +"%s"`
Y=`date +%Y`
WORKING_DIR=`pwd`
LOG_DIR_PATH="${WORKING_DIR}/SYSM"
LOG_FILE_NAME="log"
LOG_FILE_PATH="${LOG_DIR_PATH}/${LOG_FILE_NAME}${FILE_DATE}.log"
KERNEL=`uname -r`

#Color Variables
RED='\e[31m'
GRE='\e[32m'
WHT='\e[37m'
ORG='\e[33m'

#Script Start
clear

#REMOVING APT LOCK IF EXISTS
sudo rm -rf /var/lib/apt/lists/lock
sudo rm -rf /var/cache/apt/archives/lock
sudo rm -rf /var/lib/dpkg/lock
sudo dpkg --configure -a
sleep 1.5;

#Make Log Directory IF NOT EXISTS
mkdir -p ${LOG_DIR_PATH}

echo " ";
echo -e "${ORG}Debian Linux Script Statring ......${WHT}";
echo " ";

#DISPLAY AND WRITE CURRENT DATE TIME
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "Update Starts at ${DATE}"                 | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓                SYSTEM                ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓    INFORMATION    ▓      UPDATE      ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 1 ░     Operating System Details    ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE OS Details
sudo lsb_release -a                             | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE OS KERNEL
echo "OS Kernel: ${KERNEL}"                     | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 2 ░           CPU Details           ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE CPU Details
sudo lscpu                                      | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 3 ░        Hardware Details         ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sudo lshw -short | grep -v system               | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 4 ░   Synchronize Packages Sources  ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE Packages Sources Synchronization
sudo apt-get update                             | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 5 ░   Upgrade Software Packages     ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE Packages Upgrade Details
sudo apt-get upgrade                            | tee -a ${LOG_FILE_PATH}
sudo apt-get dist-upgrade                       | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 6 ░  Fixing Packages Dependencies   ░░" | tee -a ${LOG_FILE_PATH}
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
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 7 ░    Remove Obsolete Packages     ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░░           Cleaning Disk            ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE Disk Cleaning Details
sudo apt-get autoremove                      | tee -a ${LOG_FILE_PATH}
sudo apt-get autoclean                       | tee -a ${LOG_FILE_PATH}
sudo apt-get clean                           | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 8 ░          Disk Details           ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}

#DISPLAY AND WRITE Disk Details
sudo lsblk                                      | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sudo df -h                                      | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓ 1.4.0-150720221  ▓  Prasit Chanda    ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓            2015 – ${Y}               ▓" | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
DATE=`date +"%d-%B-%Y %r"`
echo "Update Ends at ${DATE}"                   | tee -a ${LOG_FILE_PATH}
echo " ";
echo -e "${ORG}Log written to ${LOG_FILE_PATH}.${WHT}";
echo -e "${RED}Debian Script Ends.${WHT}";
echo " ";
exit
#Script Ends