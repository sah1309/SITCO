
#!/bin/bash

exec 2> /home/$USER/logs/sitfire_err.log
now=$(date +"%m_%d_%Y")

###############################################################
# MSSQL                                                       #
###############################################################


#echo "Please enter search string"

#read VAR1

SQL="SELECT new_surfingip,AccountNumber,Name,new_shutoff FROM AccountBase WHERE new_shutoff LIKE '1'"
EXEC=go
SQSH=/usr/bin/sqsh
DB=sitcodynamics_MSCRM
HOST=192.168.216.106
USER=sethro
PASS=J310ackBreck4

VAR2=$($SQSH -D $DB -S $HOST -U $USER -P $PASS <<EOF
$SQL
$EXEC
EOF)

echo "$VAR2" > shutoff.txt
echo "$VAR2" > /home/sxs1385/logs/shutoff-$now.log

wait

##############################################################
# Varaible Creation                                          #
##############################################################
for ((i=1;; i++)); do
    read "d$i" || break;
done < shutoff.txt

CUST1=$(echo "$d1"| cut -c16-32)
NAME1=$(echo "$d3"| cut -c16-50)
PG1=$(echo "$CUST1"| cut -d "." -f1-3)
GW1=$(echo "$PG1".1)
#----------------Customer1
CUST2=$(echo "$d6"| cut -c16-32)
NAME2=$(echo "$d8"| cut -c16-50)
PG2=$(echo "$CUST2"| cut -d "." -f1-3)
GW2=$(echo "$PG2".1)
#----------------Customer2
CUST3=$(echo "$d11"| cut -c16-32)
NAME3=$(echo "$d13"| cut -c16-50)
PG3=$(echo "$CUST3"| cut -d "." -f1-3)
GW3=$(echo "$PG3".1)
#----------------Customer3
CUST4=$(echo "$d16"| cut -c16-32)
NAME4=$(echo "$d18"| cut -c16-50)
PG4=$(echo "$CUST4"| cut -d "." -f1-3)
GW4=$(echo "$PG4".1)
#----------------Customer4
CUST5=$(echo "$d22"| cut -c16-32)
NAME5=$(echo "$d22"| cut -c16-50)
PG5=$(echo "$CUST5"| cut -d "." -f1-3)
GW5=$(echo "$PG1".1)
#----------------Customer5
CUST6=$(echo "$d25"| cut -c16-32)
NAME6=$(echo "$d28"| cut -c16-50)
PG6=$(echo "$CUST6"| cut -d "." -f1-3)
GW6=$(echo "$PG6".1)
#----------------Customer6
CUST7=$(echo "$d31"| cut -c16-32)
NAME7=$(echo "$d33"| cut -c16-50)
PG7=$(echo "$CUST7"|cut -d "." -f1-3)
GW7=$(echo "$PG7".1)
#----------------Customer7
CUST8=$(echo "$d36"| cut -c16-32)
NAME8=$(echo "$d38"| cut -c16-50)
PG8=$(echo "$CUST8"|cut -d "." -f1-3)
GW8=$(echo "$PG8".1)
#----------------Customer8
CUST9=$(echo "$d41"| cut -c16-32 )
NAME9=$(echo "$d43"| cut -c16-50)
PG9=$(echo "$CUST9"|cut -d "." -f1-3)
GW9=$(echo "$PG9".1)
#----------------Customer9
CUST10=$(echo "$d46"| cut -c16-32)
NAME10=$(echo "$d48"| cut -c16-50)
PG10=$(echo "$CUST10"|cut -d "." -f1-3)
GW10=$(echo "$PG10".1)
#----------------Customer10
CUST11=$(echo "$d51"| cut -c16-32)
NAME11=$(echo "$d53"| cut -c16-50)
PG11=$(echo "$CUST11"| cut -d "." -f1-3)
GW11=$(echo "$PG11".1)
#----------------Customer11
CUST12=$(echo "$d56"| cut -c16-32)
NAME12=$(echo "$d58"| cut -c16-50)
PG12=$(echo "$CUST12"|cut -d "." -f1-3)
GW12=$(echo "$PG12".1)
#----------------Customer12

#Check Variables If Needed

#echo "$GW1"
#echo "$GW2"
#echo "$GW3"

#################################################
# MIKROTIK CUSTOMER ARRAY                       #
#################################################

#Customers-12-Deep
#Instead of a shutdown send web traffic to a redirect/web pay portal


MT="/ip firewall filter remove [find src-address=\"$CUST1\";/;/"
SPASS=/usr/bin/sshpass
PASW='J310ackBreck'
SS=/usr/bin/ssh
OPT=-o StrictHostKeyChecking=no
U=admin
PORT=32

#CUSTOMER-1#
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST1\"];/;/"
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST1 comment=\"$now-$NAME1\";/;/"
#CUSTOMER-2#
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST2\"];/;/"
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW2 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST2 comment=\"$now-$NAME2\";/;/"
#CUSTOMER-3#
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST3\"];/;/"
$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW3 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST3 comment=\"$now-$NAME3\";/;/"
#CUSTOMER-4#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST4\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW4 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST4 comment=\"$now-$NAME4\";/;/"
#CUSTOMER-5#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST5\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW5 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST5 comment=\"$now-$NAME5\";/;/"
#CUSTOMER-6#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST6\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW6 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST6 comment=\"$now-$NAME6\";/;/"
#CUSTOMER-7#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST7\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW7 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST7 comment=\"$now-$NAME7\";/;/"
#CUSTOMER-8#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST8\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW8 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST8 comment=\"$now-$NAME8\";/;/"
#CUSTOMER-9#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST9\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW9 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST9 comment=\"$now-$NAME9\";/;/"
#CUSTOMER-10#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST10\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW10 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST10 comment=\"$now-$NAME10\";/;/"
#CUSTOMER-11#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST11\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW11 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST11 comment=\"$now-$NAME11\";/;/"
#CUSTOMER-12#
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW1 -p 32 "/ip firewall filter remove [find src-address=\"$CUST12\"];/;/"
#$SPASS -p 'J310ackBreck' $SS -l $U -o StrictHostKeyChecking=no $GW12 -p 32 "/ip firewall filter add chain=forward action=drop src-address=$CUST12 comment=\"$now-$NAME12\";/;/"


