#!/bin/bash

#Author: Lewis Yates
#Created:   22/01/2018
#Updated:   13/02/2018
#About:  Deletion policy script to clear logs/tmp and other similar files that fill limited disk space

#variable declaration
timestamp=$(date +%Y%m%d_%H%M%S)
path="/var/log/"
filename=deletion_policy_$timestamp.txt
log=$path/$filename
HOST=$(hostname)
ERR_FILES="nodejs-*.err"
OUT_FILES="nodejs-*.out"

#find all nodejs error logs over 7 days old, delete them
error_files=$(find $path -name "$ERR_FILES"  -type f -mtime +7 -print -delete)
$error_files >> $log

#find all nodejs output logs over 7 days old, delete them
out_files=$(find $path -name "$OUT_FILES"  -type f -mtime +7 -print -delete)
$out_files >> $log

echo "Start: $(date +%Y%m%d_%H%M)" >> $log
echo "End: $(date +%Y%m%d_%H%M)" >> $log

BODY="The following files have been deleted:
$error_files, $out_files"

echo ${BODY} | mail -s "Deletion Policy $HOST" lewis.yates@roadtohealthgroup.com
