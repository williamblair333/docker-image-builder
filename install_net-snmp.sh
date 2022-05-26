#!/usr/bin/env bash

set -o errexit
set -o nounset
set -eu -o pipefail
#set -x
#trap read debug
#################################################################################
#
#Run example: ./install_net_snmp.sh
#Date:        2022MAY23
#Author:      William Blair
#Contact:     williamblair333@gmail.com
#Tested on:   Debian 11
#This script is intended to do the following:
#Setup net-snmp, pull mibs from a git repo and install them
#
#################################################################################

user=remote
user_snmp_home=home/"$user"/.snmp

# set non-free in /etc/apt/sources.list
apt-get update
apt-get --yes install snmp snmp-mibs-downloader tkmib smitools
 
sed -i 's/mibs :/#mibs :/g' /etc/snmp/snmp.conf
 
#switch to your favorite user account

mkdir -p /"$user_snmp_home"/mibs && cd /"$user_snmp_home"/mibs
echo "mibdirs +"/"$user_snmp_home""/Source" >> /"$user_snmp_home"/snmp.conf
 
git init && git pull https://github.com/williamblair333/mibs.git && cd Source
download-mibs
