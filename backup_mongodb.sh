#!/bin/bash

USERNAME=admin
PASSWORD=<insert_your_insecure_pass_here>
BACKUP_DIR="/backup/mongodb"
BACKUP_RETENTION=4
LOG_FILE=/var/log/mongo/mongod.log
LOG_RETENTION=90

# Backup databases
NOW=$(date +"%F")
mongodump --out=$BACKUP_DIR/$NOW --username=$USERNAME --password=$PASSWORD
tar czf $BACKUP_DIR/$NOW.tgz $BACKUP_DIR/$NOW && rm -rf $BACKUP_DIR/$NOW

# Delete old backups
find $BACKUP_DIR -name "????-??-??.tgz" -mtime +$BACKUP_RETENTION -exec rm {} \;

# Rotate logs
/usr/bin/killall -SIGUSR1 mongod
gzip $LOG_FILE.????-??-??T??-??-??

# Delete old logs
find $(dirname $LOG_FILE) -name "$(basename $LOG_FILE).????-??-??T??-??-??.gz" -mtime +$LOG_RETENTION -exec rm {} \;

# Copy to backup main server
(...)
