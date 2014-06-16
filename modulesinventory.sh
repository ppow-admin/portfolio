#!/bin/bash
#
#Script that would return an inventory of what modules of the application were installed on a given environment machine. This was a result of QA constantly asking us which modules were installed on various machines they used for testing. This was later expanded to include production servers known as "pods".
#
#Module Inventory script...see Seth Floyd for info if needed.
#

if [[ $1 ]]; then
    choice=$1
else
    read -p "Enter which Prod or Non-Prod server would you like to inventory?(Enter in the format of:qa1 or pod1) : " choice
fi



invhome=`hostname`
user="app"
invoutputdir="/tmp/modulesinventory"
invoutputfile="$invoutputdir/modulesinventory.txt"
bginvoutputfile="$invoutputdir/bgmodulesinventory.txt"
tmpinvoutputfile="/tmp/modulesinventory.txt"
robosrv="vweb01.atlnp1"
roboinvoutputfile="$invoutputdir/robomodulesinventory.txt"
prodrobosrv="vweb04.atlc1"
prodroboinvoutputfile="$invoutputdir/robomodulesinventory.txt"


#get modules
getmoduleslist () {
echo "Getting the modules together..."
echo "If directories are not found thats ok. It just means its not in the list of all directories searched."
#produce the module list and also grab the info from the robo server
 if [[ $bgsvr ]]; then
    ssh $user@$bginvsvr "find $bginvmodulehome -type l  -exec ls -l {} \; |grep -v old | sed -e 's/\\/*$//g' | awk -F"/" '{ print \$NF }' |sort -d > $tmpinvoutputfile"
    ssh $user@$prodrobosrv "find /app/robohtml -type l  -exec ls -l {} \; |grep -v old | sed -e 's/\\/*$//g' | awk -F"/" '{ print \$NF }' |sort -d > $tmpinvoutputfile"
    ssh $user@$invsvr "find $invmodulehome -type l  -exec ls -l {} \; |grep -v old | sed -e 's/\\/*$//g' | awk -F"/" '{ print \$NF }' |sort -d > $tmpinvoutputfile"

    scp $user@$bginvsvr:$tmpinvoutputfile $bginvoutputfile
    scp $user@$invsvr:$tmpinvoutputfile $invoutputfile
    scp $user@$prodrobosrv:$tmpinvoutputfile $prodroboinvoutputfile

    cat $bginvoutputfile > $invfiletmp
    cat $invoutputfile >> $invfiletmp
    cat $prodroboinvoutputfile >> $invfiletmp


 else

#
#directive for mapp severs
#
ssh $user@$invsvr "find $invmodulehome -type l  -exec ls -l {} \; |grep -v old | sed -e 's/\\/*$//g' | awk -F"/" '{ print \$NF }' |sort -d > $tmpinvoutputfile"
ssh $user@$robosrv "find /app/robohtml -type l  -exec ls -l {} \; |grep -v old | sed -e 's/\\/*$//g' | awk -F"/" '{ print \$NF }' |sort -d > $tmpinvoutputfile"
#get the file from the server over to ctier server
scp $user@$invsvr:$tmpinvoutputfile $invoutputfile
scp $user@$robosrv:$tmpinvoutputfile $roboinvoutputfile

#add to the final file
 cat $roboinvoutputfile > $invfiletmp
 cat $invoutputfile >> $invfiletmp
 fi
}

#Folder cleanup
clean () {
 if [ -d  "$invoutputdir" ];
 then
  rm -rf $invoutputdir && mkdir $invoutputdir;
 else
  mkdir $invoutputdir;
 fi
}

#this finds the files on the app server and bkgrnd server if provided (bkgrnd server will only come into play with PODs)
inventory () {
 invfiletmp="$invoutputdir/modinv$choice.txt"
 invfinalfile="$invoutputdir/modulesinventory$choice.txt"
 #if [[ $appsvr ]]; then
   # invsvr=$appsvr
    #invmodulehome=$appmodulehome
    #getmoduleslist
 #fi
 if [[ $bgsvr ]]; then
   bginvsvr=$bgsvr
   invsvr=$appsvr
   bginvmodulehome=$bgmodulehome
   invmodulehome=$appmodulehome
   getmoduleslist

 else
   invsvr=$appsvr
   invmodulehome=$appmodulehome
   getmoduleslist

 fi

 sort -d "$invfiletmp" -o "$invfiletmp"
 cat "$invfiletmp" | sed -e '/mq/d' > "$invfinalfile"
 echo "Your file with output can be found in $invfinalfile"
 cat "$invfinalfile"
 rm -f "$invfiletmp"

}



case $choice in

######################################
#Collects the MAPP server dirs       #
######################################

qa1) {
    appsvr="vqa01.atlnp1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/smsin /app/sso /app/transact"
    clean
    inventory
}
;;

qa2) {
    appsvr="vqa02.atlnp1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/smsin /app/sso /app/transact"
    clean
    inventory
}
;;

qa3) {
    appsvr="vqa03.atlnp1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    clean
    inventory
}
;;

qa4){
    appsvr="vqa04.atlnp1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/smsin /app/sso /app/transact"
    clean
    inventory
}
;;

######################################
#Collects the POD server dirs including BKGRND servers #
######################################

pod1){
    appsvr="rapp11.atlis1"
    bgsvr="rbg11.atlis1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    bgmodulehome="/app/campaigns /app/crmi /app/lpages /app/marketer /app/reporting /app/transact"
    clean
    inventory
}
;;

pod2){
    appsvr="rapp14.atlis1"
    bgsvr="rbg14.atlis1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    bgmodulehome="/app/campaigns /app/crmi /app/lpages /app/marketer /app/reporting /app/transact"
    clean
    inventory
}
;;

pod3){
    appsvr="app01.pdkp1"
    bgsvr="rbg01.pdkp1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    bgmodulehome="/app/campaigns /app/crmi /app/lpages /app/marketer /app/reporting /app/transact"
    clean
    inventory
}
;;

pod4){
    appsvr="app01.pdkp2"
    bgsvr="rbg01.pdkp2"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    bgmodulehome="/app/campaigns /app/crmi /app/lpages /app/marketer /app/reporting /app/transact"
    clean
    inventory
}
;;

pod5){
    appsvr="rapp17.atlis1"
    bgsvr="rbg17.atlis1"
    appmodulehome="/app/campaigns /app/crmi /app/engage /app/lpages /app/marketer /app/reporting /app/sso /app/transact"
    bgmodulehome="/app/campaigns /app/crmi /app/lpages /app/marketer /app/reporting /app/transact"
    clean
    inventory
}
;;




*) echo "Please enter the mapp or pod you need the modules for in the format of qa1 or pod1"
;;

