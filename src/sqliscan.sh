#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/reconizer/ ]
then
  echo " "
else
  mkdir ~/reconizer
fi

if [ -d ~/reconizer/$DOM/vulnerabilities]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/vulnerabilities
fi

if [ -d ~/reconizer/$DOM/vulnerabilities/sqli]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/vulnerabilities/sqli
fi

echo "${red}
 =================================================
|   ____  _____  ____ ___  _   _ _                |
|  |  _ \|___ / / ___/ _ \| \ | (_)_______ _ __   |
|  | |_) | |_ \| |  | | | |  \| | |_  / _ \ '__|  |
|  |  _ < ___) | |__| |_| | |\  | |/ /  __/ |     |
|  |_| \_\____/ \____\___/|_| \_|_/___\___|_|     |
|                                                 |
 ================== Anon-Artist ==================
${reset}"
echo "${blue} [+] Started sqli Vulnerability Scanning ${reset}"
echo " "

#sqli
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/usr/bin/sqlmap ]
then
echo -e ${CG}"\n[+] Searching For SQL Injection:- "
sqlmap -m $DOM/GF_Pattern/sql.txt --batch --random-agent --level 1 | tee $DOM/vulnerabilities/sqli/sqlmap.txt
else
  echo "${blue} [+] Installing sqli ${reset}"
  sudo apt install sqlmap
echo -e ${CG}"\n[+] Searching For SQL Injection:- "
sqlmap -m $DOM/GF_Pattern/sql.txt --batch --random-agent --level 1 | tee $DOM/vulnerabilities/sqli/sqlmap.txt
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
