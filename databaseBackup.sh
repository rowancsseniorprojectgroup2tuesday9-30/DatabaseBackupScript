#!/bin/bash
# DATABASE BACKUP SCRIPT
# POPULATE THE FOLLOWING VARIABLES:
#   WORKINGDIR, BACKUPLOCATION

DATE=$(date +%F.%T)

WORKINGDIR="/home/ec2-user/db_backups"
cd $WORKINGDIR

# Three different arguments may be specified.
# -d : daily backup
# -w : weekly backup
# -m : monthly backup
while getopts dwm option
do
    case "${option}"
        in
        d) BACKUPLOCATION="daily";;
        w) BACKUPLOCATION="weekly";;
        m) BACKUPLOCATION="monthly";;
    esac
done

# rsync -rav $DATABASELOCATION $BACKUPLOCATION/$DATE
mysqldump --all-databases > $BACKUPLOCATION/$DATE.sql

# Only keep 2 backups
find $BACKUPLOCATION/* -type f | sort -r | sed -n '3,$p' | xargs rm
