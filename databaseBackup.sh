#!/bin/bash
# DATABASE BACKUP SCRIPT
# POPULATE THE FOLLOWING VARIABLES:
#   DATABASELOCATION, BACKUPLOCATION

DATE=$(date +%F.%T)

# Location of database file(s)
DATABASELOCATION=""

# Three different arguments may be specified.
# -d : daily backup
# -w : weekly backup
# -m : monthly backup
while getopts dwm option
do
    case "${option}"
        in
        d) BACKUPLOCATION="/daily";;
        w) BACKUPLOCATION="/weekly";;
        m) BACKUPLOCATION="/monthly";;
    esac
done

rsync -rav $DATABASELOCATION $BACKUPLOCATION/$DATE

# Only keep 2 backups
find $BACKUPLOCATION/* -type d | sort -r | sed -n '3,$p' | xargs rm -r

# TODO: Check if there are more that 2 backups before attempting to remove
