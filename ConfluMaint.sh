#!/bin/bash -x
#
#Script I created to aid in the backup process of our Confluence instance
#

##Date format##
TODAY=$(date +%m-%d-%Y)
##Backup Directory##
BACKUPDIR="/mnt/dev-backup-nfs/confluence"
##Home Directory##
HOMEDIR="/var/opt"
##Mail Info##
MAILOUT="/tmp/${DB_NAME}-mail.txt"

#Sounding the alarm to notify someone something is wrong
SOUNDALARM() {
    cat "The script at /var/ConfluenceBKUP.sh on vcmwiki.atld1 has failed" | /var/mail.rb "Backup of Confluence has failed" cmteam@XXXXXXXX.XXXX
}

##navigate to where the backup files are located
echo "Going to home dir..."
cd $HOMEDIR/atlassian/application-data/confluence/backups

#Clean up dir
echo "Cleaning up older ZIP backup files created by Confluence..."
find . -type f -name 'backup-*.zip' -mtime +3 -exec rm -f {} \;
echo "Cleaning up older backup tars created by this script..."
find $BACKUPDIR -type f -name 'ConfluenceBKUP-*.tar' -mtime +3 -exec rm -f {} \;

#navigate to /var/
cd $HOMEDIR

#tar up  in /var/opt and name it ConfluenceBKUP.tar
echo "Tarring up the folders..."
tar -cf ConfluenceBKUP-$TODAY.tar $HOMEDIR/atlassian/ $HOMEDIR/confluence-4.1.4/

#move ConfluenceBKUP.tar to backup server
echo "Moving the tarred up file to the backup location..."
mv ConfluenceBKUP-$TODAY.tar  $BACKUPDIR/ConfluenceBKUP-$TODAY.tar

#check to see if file from TODAY exists
  if [ -f ${BACKUPDIR}/ConfluenceBKUP-${TODAY}.tar ]
   then
   echo "Backup Complete"
   else
    SOUNDALARM
  fi



