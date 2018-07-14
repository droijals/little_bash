#####
#
# Control script for MySQL lag of BI Amazon's database
#
# Aquest script es troba al cron del nagios, i executa cada 2 hores una consulta per veure si tenim lag i/o
# errors a una bbdd que els companys de BI tenen a Amazon. Si tenim lag i/o errors ens envïa un mail als 
# sysadmins per tal que actúem.
#
#####

#!/bin/bash

# Variables definition
HOST=<bbdd_host_whatever>eu-west-1.rds.amazonaws.com
PORT=3306
USER=<ask_for_it_to_any_sysadmin>
PASSWD=<ask_for_it_to_any_sysadmin>
LOG=/var/log/bbdd_BI_amazon_out.log
SUBJECT='AMAZON_BI_BBDD_LAG_SLAVE_STATUS'
EMAIL='droijals@gmail.com'

# Purge log
rm /var/log/bbdd_BI_amazon_out.log

# Adding date + command result at log
date > $LOG

# Manual nagios (shinken) check. 
/var/lib/shinken/libexec/check_mysql_slavestatus.sh -H $HOST -P $PORT -u $USER -p $PASSWD >> $LOG

# Verifyin' 
OK=$(cat $LOG | grep -c "delay=0s")

if [ $OK != 1 ]; then
   # If we've got delay (or an error) send an email
   mailx -s $SUBJECT $EMAIL < $LOG
   echo "";
else
 # No delay, no party
   echo "";
fi


