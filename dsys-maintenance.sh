#! /bin/bash

# ───────────────────────────────────────────────────────────────
# Script: system_maintenance.sh
# Purpose: System update, cleanup, and hardware diagnostics
# Author: Prasit Chanda
# Version: 1.3.2-2812201625
# Date: 28 December 2016
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

#Script Strats
clear
#Remove apt-get lock
sudo rm -f /var/lib/dpkg/lock
#Make Log Directory IF NOT EXISTS
mkdir -p ${LOG_DIR_PATH}

echo " ";
echo -e "${ORG}Debian Linux Script Statring ......${WHT}";
echo " ";
echo -e "${GRE}Checking required packages   ......${WHT}";
echo " ";

#Checking whether required packages are installed
#lshw Package
PACKAGE_NAME="lshw"
PACKAGE=`dpkg-query -W -f='${Status}' $PACKAGE_NAME 2>/dev/null | grep -c "ok installed"`
if [  "0" == "$PACKAGE"  ]; then
  echo $PACKAGE_NAME is not installed
  echo Intalling $PACKAGE_NAME ......
  sudo apt-get install $PACKAGE_NAME
  sleep 0.5
else
  echo $PACKAGE_NAME is installed
fi
#python-pip::speedtest-cli Package
PACKAGE_NAME_2="speedtest-cli"
PACKAGE_NAME_2a="python-pip"
PACKAGE_2a=`dpkg-query -W -f='${Status}' $PACKAGE_NAME_2a 2>/dev/null | grep -c "ok installed"`
if [  "0" == "$PACKAGE_2a"  ]; then
  echo $PACKAGE_NAME_2a is not installed
  echo Intalling $PACKAGE_NAME_2a ......
  sudo apt-get install $PACKAGE_NAME_2a
  sleep 0.5
  echo $PACKAGE_NAME_2a $PACKAGE_NAME_2 is not installed
  echo Intalling $PACKAGE_NAME_2a $PACKAGE_NAME_2 ......
  sudo pip install $PACKAGE_NAME_2
  sleep 0.5
else
  echo $PACKAGE_NAME_2a is installed
  sudo -H pip install --upgrade pip
  PACKAGE_2=`pip show $PACKAGE_NAME_2`
  if [  "" == "$PACKAGE_2"  ]; then
    echo $PACKAGE_NAME_2a $PACKAGE_NAME_2 is not installed
    echo Intalling $PACKAGE_NAME_2a $PACKAGE_NAME_2 ......
    sudo pip install $PACKAGE_NAME_2
    sleep 0.5
  else
    echo $PACKAGE_NAME_2a $PACKAGE_NAME_2 is installed  
    echo Upgrading $PACKAGE_NAME_2a $PACKAGE_NAME_2 ......
    sudo -H pip install speedtest-cli --upgrade	
  fi
fi

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
echo "░ 4 ░     Internet Speed Details      ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sudo speedtest-cli                              | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 5 ░   Synchronize Packages Sources  ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Packages Sources Synchronization
sudo apt-get update                             | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 6 ░   Upgrade Software Packages     ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Packages Upgrade Details
sudo apt-get upgrade                            | tee -a ${LOG_FILE_PATH}
sudo apt-get dist-upgrade                       | tee -a ${LOG_FILE_PATH}
sleep 0.5;
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
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "░ 8 ░    Remove Obsolete Packages     ░░" | tee -a ${LOG_FILE_PATH}
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
echo "░ 9 ░          Disk Details           ░░" | tee -a ${LOG_FILE_PATH}
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
#DISPLAY AND WRITE Disk Details
sudo lsblk                                      | tee -a ${LOG_FILE_PATH}
echo "                                        " | tee -a ${LOG_FILE_PATH}
sudo df -h                                      | tee -a ${LOG_FILE_PATH}
sleep 0.5;
echo "                                        " | tee -a ${LOG_FILE_PATH}
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓" | tee -a ${LOG_FILE_PATH}
echo "▓ 1.3.2-2812201625  ▓  Prasit Chanda   ▓" | tee -a ${LOG_FILE_PATH}
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