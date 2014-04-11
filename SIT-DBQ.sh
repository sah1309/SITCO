#!/bin/bash

#Who wrote this mother:
#Seth Hildenbrand

#STERR REDIRECT#
#IF NEED LOGS DIRECT TO FILE#
exec 2> /home/sitco/logs/sitdb.log

###############################################################
#  MYSQL QUERIES JUST HAPPENED                                #
###############################################################


MSQ=$(mysql -s -n -h 10.0.0.11 -u user -p'pass' << EOF
use radius;
SELECT max(id) FROM radcheck;
EOF)

MSQ1=$(mysql -s -n -h 10.0.0.11 -u user -p'pass' << EOF
use radius;
SELECT username FROM radcheck where id= '$MSQ';
EOF)

MSQ2=$(mysql -h 10.0.0.11 -u user -p'pass' << EOF
use radius;
SELECT contractid FROM rm_users WHERE username LIKE '$MSQ1';
EOF)

MSQ3=$(echo "$MSQ2" | grep -Eo '[A-Z][0-9][0-9][0-9][0-9]|[A-Z][A-Z][0-9][0-9][0-9][0-9]')


###############################################################
# MSSQL QUERIES GETTING DOWN                                  #
###############################################################


#echo "Please enter search string"

#read VAR1

SQL="SELECT new_surfingip, new_downloadspeed,new_uploadspeed,AccountNumber,new_managementip,Name FROM AccountBase WHERE AccountNumber LIKE '$MSQ3'"
EXEC=go
SQSH=/usr/bin/sqsh
DB=sitcodynamics_MSCRM
HOST=192.168.216.106
USER=user
PASS=password


VAR2=$($SQSH -D $DB -S $HOST -U $USER -P $PASS <<EOF
$SQL
$EXEC
EOF)

#PULLS CUSTOMER NAME====>
        NAM=$(echo "$VAR2" | sed -n '/Name/p' | cut -c20-60 )
#PULLS CUSTOMER DOWNLOAD SPEED====>
                DOWN=$(echo "$VAR2" | sed -n '/new_downloadspeed/p' | cut -c20-25)
#PULLS CUSTOMER UPLOAD SPEED====>
                        UP=$(echo "$VAR2" | sed -n '/new_uploadspeed/p' | cut -c20-25)
#PULLS CUSTOMER IP====>
                                IP=$(echo "$VAR2" | sed -n '/new_surfingip/p' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
#PULLS CUSTOMER ACCOUNT NUMBER====>
                                        ACC=$(echo "$VAR2" | sed -n '/AccountNumber/p'| grep -Eo '[A-Z][0-9][0-9][0-9][0-9]|[A-Z][A-Z][0-9][0-9][0-9][0-9]' )
#PULLS 1ST 3 OCTETS OF CUSTOMER====>
                                                TOC=$(echo "$IP"| cut -d "." -f1-3)
#CREATES GATEWAY VARIABLE====>
                                                        GW=$(echo "$TOC".1)

echo "$VAR2" > /home/sitco/logs/radius_auth.log
echo "$GW"   > /home/sitco/logs/radius_auth.log
echo "$IP"   > /home/sitco/logs/radius_auth.log
echo "$UP"  >> /home/sitco/logs/radius_auth.log
echo "$DOWN">> /home/sitco/logs/radius_auth.log
echo "$NAM" >> /home/sitco/logs/radius_auth.log




###################################################################################
# MIKROTIK DYNAMIC QUEUE TAKING PLACE                                             #
###################################################################################

#GET ADDRESS PARAMS FROM ABOVE SCRIPT

MT="/queue simple add target=$IP name=\"$IP - $NAM\" max-limit=$UP/$DOWN;/;/"
SPASS=/usr/bin/sshpass
PASW='pass'
SS=/usr/bin/ssh
OPT=-o StrictHostKeyChecking=no
U=user
PORT=32

$SPASS -p 'pass' $SS -l $U -o StrictHostKeyChecking=no $GW -p 32 $MT


##SEND echo requests to a log file and send email to server
